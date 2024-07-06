#import pymysql
from db import conectarMySQL


    # Read -> SELECT
def obtener_consagraciones_filtradas(era, ambito, competencia_tipo):
    conexion = conectarMySQL()
    resultados = []
    with conexion.cursor() as cursor:
        sql = """
        SELECT equipo.nombre, SUM(consagraciones_equipo.cantidad) as total
        FROM consagraciones_equipo 
        JOIN equipo ON consagraciones_equipo.equipo = equipo.id 
        JOIN competencia ON consagraciones_equipo.competencia = competencia.id
        """

        params = []
        
        if era != "0":
            sql += " AND competencia.era = %s"
            params.append(era)
        if ambito != "0":
            sql += " AND competencia.ambito = %s"
            params.append(ambito)
        if competencia_tipo != "0":
            sql += " AND competencia.tipo = %s"
            params.append(competencia_tipo)
        
        sql += " GROUP BY equipo.id ORDER BY total DESC"
        
        cursor.execute(sql, params)
        resultados = cursor.fetchall()
    
    conexion.close()
    return [{"equipo": r[0], "cantidad": r[1]} for r in resultados]


def obtener_hinchas():
    conexion = conectarMySQL()
    hinchas = []
    with conexion.cursor() as cursor:
        sql = "SELECT * FROM hinchas ORDER BY puesto"
        cursor.execute(sql)
        hinchas = cursor.fetchall()
    conexion.close()
    return hinchas