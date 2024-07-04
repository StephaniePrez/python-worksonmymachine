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
    