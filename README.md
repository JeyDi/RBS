# RBS
### Reti Booking System

Reti Booking System è un sistema di prenotazione web realizzato con .Net Framework 4.7, Typescript, e SQL Server.  
E' un'applicazione full-stack realizzata con uno stack microsoft MVC a cui è stata applicata una logica di realizzazione tipica dei progetti enterprise per scopo di studio  
  
Il sistema consente di effettuare delle prenotazioni, cancellarle, creare nuove risorse (persone), creare delle sale riunioni oppure dei nuovi edifici sul modello aziendale Reti.  
  
Per avviare il progetto è necessario scaricare la solution, creare il DB SQL Server con il relativo script (sia per Windows che per Linux), successivamente avviare la solution di Visual Studio (solo Windows) e fare la build del progetto.  
  
Elenco delle funzionalità:  
- Creazione di una risorsa
- Elenco delle risorse e dettaglio di una risorsa
- Creazione di un edificio
- Elenco degli edifici e dettaglio di un edificio
- Creazione di una sala
- Elenco delle sale e dettaglio di una sala
- Inserimento di una prenotazione
- Elenco delle prenotazioni ed eliminazione di una prenotazione
- Eliminazione di una prenotazione
- Email di supporto

Inoltre all'interno del progetto sono stati integrati i seguenti design pattern:
- Repository
- Unity of Work  
  
Questo perchè è stato utilizzato Entity Framework come ORM in modalità Database-First, si è reso quindi necessario mappare all'interno del progetto anche le stored procedure oltre alle tabelle.  
Conseguentemente, la maggior parte della logica applicativa risiede all'interno della struttura dati.

  
Funzionalità aggiuntive non ancora pronte:  
- Login utente: al momento è possibile identificare un utente selezionando la rispettiva dropdown
- Invio delle email: ci sono alcuni problemi con il provider di posta SMTP






