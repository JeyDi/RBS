Procedura per aggiornare una stored procedure con Entity Framework a mano **DB First** (dato che il modello manuale non funziona e non aggiorna in automatico le informazioni, non so come mai..)

1) andare su Model Browser e cancellare la stored in 3 punti
	1. Complex Type
	2. Function import
	3. StoredProcedure
	
SALVARE IL MODELLO

2) Aggiornare il modello inserendo nuovamente la stored

SALVARE IL MODELLO UNA SECONDA VOLTA

(La stored verrà inserita in fondo al file)

Se il model Browser su Visual Studio non funziona e non si vede niente all'interno della finestra
Tools -> Options -> General -> Uncheck Optimize rendering for screens with different pixel densities 