using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Metadata.Edm;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace RBS.DAL
{
    public class EFRepository<TEntity> : IRepository<TEntity> where TEntity : class
    {
        private string mSchema = string.Empty;

        private string mEntityName = string.Empty;
        private DbContext mContext;
        private DbSet<TEntity> mDbSet;

        protected DbContext Context
        {
            get { return mContext ?? (mContext = ((EFUnitOfWork)GlobalUnitOfWork.Current).Context); }
        }

        protected DbSet<TEntity> DbSet
        {
            get { return mDbSet ?? (mDbSet = Context.Set<TEntity>()); }
        }

        public string Schema
        {
            get
            {
                if (mSchema == string.Empty)
                {
                    var objContext = ((IObjectContextAdapter)Context).ObjectContext;
                    var items = objContext.MetadataWorkspace.GetItems<EntityContainer>(DataSpace.SSpace);
                    var container = items != null ? items.First() : null;
                    if (container != null)
                        mSchema = container.BaseEntitySets.SingleOrDefault(e => e.Name == typeof(TEntity).Name).Schema;
                }

                return mSchema;
            }
        }

        public string EntityName
        {
            get
            {
                if (mEntityName == string.Empty)
                {
                    var objContext = ((IObjectContextAdapter)Context).ObjectContext;
                    var items = objContext.MetadataWorkspace.GetItems<EntityContainer>(DataSpace.SSpace);
                    var container = items != null ? items.First() : null;
                    if (container != null)
                        mEntityName = container.BaseEntitySets.SingleOrDefault(e => e.Name == typeof(TEntity).Name).Name;
                }

                return mEntityName;
            }
        }

        public string TableNameForSqlQuery
        {
            get { return string.Format("{0}.{1}", Schema, EntityName); }
        }

        public IQueryable<TEntity> GetQuery()
        {
            return DbSet;
        }

        public IEnumerable<TEntity> GetAll()
        {
            return DbSet.ToList();
        }


        public IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> where)
        {
            return DbSet.Where(where);
        }

        public IEnumerable<TEntity> FindAsNoTracking(Expression<Func<TEntity, bool>> where)
        {
            return DbSet.Where(where).AsNoTracking();
        }

        public IQueryable<TEntity> FindAsNoTrackingQueryable(Expression<Func<TEntity, bool>> where)
        {
            return DbSet.Where(where).AsNoTracking();
        }

        public TEntity Single(Expression<Func<TEntity, bool>> where)
        {
            return DbSet.Where(where).SingleOrDefault();
        }

        public TEntity First(Expression<Func<TEntity, bool>> where)
        {
            return DbSet.Where(where).First();
        }

        public void Delete(TEntity entity)
        {
            if (Context.Entry(entity).State == EntityState.Detached)
            {
                DbSet.Attach(entity);
            }
            DbSet.Remove(entity);
        }

        public void Add(TEntity entity)
        {
            DbSet.Add(entity);
        }

        public void AddAndSave(TEntity entity)
        {
            DbSet.Add(entity);
            mContext.SaveChanges();
        }

        public void DeleteAndSave(TEntity entity)
        {
            DbSet.Remove(entity);
            mContext.SaveChanges();
        }

        public void DeleteRange(IEnumerable<TEntity> listEntity)
        {
            DbSet.RemoveRange(listEntity);
        }

        public void DeleteRangeAndSave(IEnumerable<TEntity> listEntity)
        {
            DeleteRange(listEntity);
            mContext.SaveChanges();
        }

        public void AttachRange(IEnumerable<TEntity> listEntity)
        {
            foreach (TEntity elem in listEntity)
            {
                DbSet.Attach(elem);
            }
        }

        public void DeattachRange(IEnumerable<TEntity> listEntity)
        {
            foreach (TEntity elem in listEntity)
            {
                Context.Entry(elem).State = EntityState.Detached;
            }
        }

        public string CreateStringSql<T>(IQueryable<T> query)
        {
            return ((System.Data.Entity.Core.Objects.ObjectQuery)query).ToTraceString();
        }

        /// <summary>
        /// Immediately inserts a list of entities into the database
        /// </summary>
        /// <param name="listEntity"></param>
        public void AddRange(IEnumerable<TEntity> listEntity)
        {
            DbSet.AddRange(listEntity);
        }

        public void AddRangeAndSaveWithoutBulkInsert(IEnumerable<TEntity> listEntity)
        {
            DbSet.AddRange(listEntity);
            Context.SaveChanges();
        }

        public void Update(TEntity entity)
        {
            DbSet.Attach(entity);
            Context.Entry(entity).State = EntityState.Modified;
        }

        public void UpdateAndSave(TEntity entity)
        {
            DbSet.Attach(entity);
            Context.Entry(entity).State = EntityState.Modified;
            Context.SaveChanges();
        }


        public void UpdateRangeSave(IEnumerable<TEntity> listEntityToUpdate)
        {
            foreach (TEntity entity in listEntityToUpdate)
            {
                DbSet.Attach(entity);
                Context.Entry(entity).State = EntityState.Modified;
            }
            Context.SaveChanges();
        }


     

    }
}
