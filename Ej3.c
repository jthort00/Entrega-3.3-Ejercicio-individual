//Programa en C para crear una base de datos
//Incluir esta libreriï¾­a para poder hacer las llamadas en shiva2.upc.es
//#include <my_global.h> 
#include <mysql.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
int main(int argc, char **argv)
{
	//Conector para acceder al servidor de bases de datos 
	MYSQL *conn;
	MYSQL_RES *resultado;
	MYSQL_ROW row;
	int gameid;
	
	int err;
	//Creamos una conexion al servidor MYSQL 
	conn = mysql_init(NULL);
	if (conn==NULL) {
		printf ("Error al crear la conexion: %u %s\n", 
				mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	
	//inicializar la conexion, indicando nuestras claves de acceso
	// al servidor de bases de datos (user,pass)
	conn = mysql_real_connect (conn, "localhost","root", "mysql", NULL, 0, NULL, 0);
	if (conn==NULL)
	{
		printf ("Error al inicializar la conexion: %u %s\n", 
				mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	// ahora vamos a crear la base de datos, que se llamara personas
	// primero la borramos si es que ya existe (quizas porque hemos
	// hecho pruebas anteriormente
	mysql_query(conn, "source Monopoly10.sql;"); 
	mysql_query(conn, "use Monopoly;");
	err=mysql_query (conn, "SELECT Games.gameID, PlayerStatus.playerID FROM Games, PlayerStatus WHERE Games.gameID = PlayerStatus.gameID AND PlayerStatus.jail = 1 AND PlayerStatus.money > 100;");
	if (err!=0) {
		printf ("Error al consultar datos de la base %u %s\n",
				mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	
	resultado = mysql_store_result (conn);
	row = mysql_fetch_row (resultado);
	printf("Los jugadores en prisión con más de 100 euros son:\n\n");
	if (row == NULL)
		printf ("No se han obtenido datos en la consulta\n");
	
	else
		while (row !=NULL) {
			// la columna 2 contiene una palabra que es la edad
			// la convertimos a entero 
			gameid = atoi (row[0]);
			// las columnas 0 y 1 contienen DNI y nombre 
			printf ("In game %d, %s\n", gameid, row[1]);
			// obtenemos la siguiente fila
			row = mysql_fetch_row (resultado);
	}
	
	// ahora tenemos la base de datos lista en el servidor de MySQL
	// cerrar la conexion con el servidor MYSQL 
	mysql_close (conn);
	exit(0);
}


	


