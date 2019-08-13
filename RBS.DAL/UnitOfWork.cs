using System;
using System.Collections.Concurrent;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.ServiceModel;
using System.Threading;
using System.Web;

namespace RBS.DAL
{
    public interface IUnitOfWork : IDisposable
    {
        int Commit();
    }

    public static class GlobalUnitOfWork
    {
        private static readonly ConcurrentDictionary<Thread, IUnitOfWork> _threads = new ConcurrentDictionary<Thread, IUnitOfWork>();
        private const string CONTEXTKEY = "UofContextKey";

        public static void Commit()
        {
            var unitOfWork = GetUnitOfWork();

            if (unitOfWork != null)
            {
                unitOfWork.Commit();
            }
        }

        public static IUnitOfWork Current
        {
            get
            {
                var unitOfWork = GetUnitOfWork();

                if (unitOfWork == null)
                {
                    unitOfWork = new EFUnitOfWork(new RBSEntities());
                    SaveUnitOfWork(unitOfWork);
                }

                return unitOfWork;
            }
        }

        private static IUnitOfWork GetUnitOfWork()
        {
            if (HttpContext.Current != null)
            {
                if (HttpContext.Current.Items.Contains(CONTEXTKEY))
                {
                    return (IUnitOfWork)HttpContext.Current.Items[CONTEXTKEY];
                }
                return null;
            }
            if (OperationContext.Current != null && OperationContext.Current.RequestContext != null)
            {
                if (OperationContext.Current.RequestContext.RequestMessage.Properties.ContainsKey(CONTEXTKEY))
                {
                    return (IUnitOfWork)OperationContext.Current.RequestContext.RequestMessage.Properties[CONTEXTKEY];
                }
                return null;
            }
            IUnitOfWork uow;
            _threads.TryGetValue(Thread.CurrentThread, out uow);
            // uow is null if not found in dictionary
            return uow;
        }

        private static void SaveUnitOfWork(IUnitOfWork unitOfWork)
        {
            if (HttpContext.Current != null)
            {
                HttpContext.Current.Items[CONTEXTKEY] = unitOfWork;
            }
            else if (OperationContext.Current != null && OperationContext.Current.RequestContext != null)
            {
                OperationContext.Current.RequestContext.RequestMessage.Properties[CONTEXTKEY] = unitOfWork;
            }
            else
            {
                _threads[Thread.CurrentThread] = unitOfWork;

                CleanupDead();
            }
        }

        private static void CleanupDead()
        {
            var toCleanup = _threads.Where(x => !x.Key.IsAlive).Select(x => x.Key).ToList();
            foreach (var thread in toCleanup)
            {
                IUnitOfWork uow;
                if (_threads.TryRemove(thread, out uow) && uow != null)
                {
                    uow.Dispose();
                }
            }
        }

        public static void Flush()
        {
            var unitOfWork = GetUnitOfWork();
            if (unitOfWork != null)
            {
                unitOfWork.Dispose();
                SaveUnitOfWork(null);
            }
        }

    }


    public class EFUnitOfWork : IUnitOfWork, IDisposable
    {
        public DbContext Context { get; private set; }

        public EFUnitOfWork(DbContext context)
        {
            Context = context;
            context.Configuration.LazyLoadingEnabled = true;
        }


        public int Commit()
        {
            try
            {
                return Context.SaveChanges();
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateConcurrencyException dbux)
            {
                string message = "Affected Entries are:";
                foreach (var en in dbux.Entries)
                {
                    message += en.Entity.GetType().Name;
                }
                throw new ApplicationException(message, dbux);
            }
        }


        public void Dispose()
        {
            if (Context != null)
            {
                Context.Dispose();
                Context = null;
            }

            GC.SuppressFinalize(this);
        }


    }







}
