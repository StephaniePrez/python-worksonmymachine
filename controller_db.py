#import pymysql
from db import conectarMySQL


# Read -> SELECT
def obtenerHinchas():
    # conexion mysql
    conexion = conectarMySQL()
    productos = []
    with conexion.cursor() as cursor:
        # Create a new record
        sql = """SELECT * FROM hinchas"""
        cursor.execute(sql)
        productos = cursor.fetchall()
        conexion.commit()
        conexion.close()
        return productos
    

    # Read -> SELECT
def obtenerCopas():
    # conexion mysql
    conexion = conectarMySQL()
    productos = []
    with conexion.cursor() as cursor:
        # Create a new record
        sql = """SELECT * FROM copas"""
        cursor.execute(sql)
        productos = cursor.fetchall()
        conexion.commit()
        conexion.close()
        return productos

def obtener_consagraciones_filtradas(era, ambito, competencia_tipo):
    conexion = conectarMySQL()
    resultados = []
    with conexion.cursor() as cursor:
        sql = """
        SELECT e.nombre, SUM(ce.cantidad) as total
        FROM consagraciones_equipo ce
        JOIN equipo e ON ce.equipo = e.id
        JOIN competencia c ON ce.competencia = c.id
        WHERE 1=1
        """
        params = []
        
        if era != "0":
            sql += " AND c.era = %s"
            params.append(era)
        if ambito != "0":
            sql += " AND c.ambito = %s"
            params.append(ambito)
        if competencia_tipo != "0":
            sql += " AND c.tipo = %s"
            params.append(competencia_tipo)
        
        sql += " GROUP BY e.id ORDER BY total DESC"
        
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