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
        sql = "SELECT * FROM hinchas ORDER BY afiliados DESC"
        cursor.execute(sql)
        hinchas = cursor.fetchall()
    conexion.close()
    return hinchas

def obtener_equipos():
    conexion = conectarMySQL()
    equipos = []
    with conexion.cursor() as cursor:
        sql = "SELECT id, nombre FROM equipo ORDER BY id"
        cursor.execute(sql)
        equipos = cursor.fetchall()
    conexion.close()
    return equipos

def agregar_equipo(nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("INSERT INTO equipo (nombre) VALUES (%s)", (nombre,))
        conexion.commit()
    conexion.close()

def editar_equipo(id, nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("UPDATE equipo SET nombre=%s WHERE id=%s", (nombre, id))
        conexion.commit()
    conexion.close()

def eliminar_equipo(id):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("DELETE FROM equipo WHERE id=%s", (id,))
        conexion.commit()
    conexion.close()
    
def obtener_competencias():
    conexion = conectarMySQL()
    competencias = []
    with conexion.cursor() as cursor:
        sql = """
            SELECT 
                competencia.id,
                competencia_tipo.nombre AS tipo_nombre,
                competencia.nombre AS nombre,
                ambito_tipo.nombre AS ambito_nombre,
                era_tipo.nombre AS era_nombre
            FROM 
                competencia
            JOIN 
                competencia_tipo ON competencia.tipo = competencia_tipo.id
            JOIN 
                ambito_tipo ON competencia.ambito = ambito_tipo.id
            JOIN 
                era_tipo ON competencia.era = era_tipo.id;
            """
        cursor.execute(sql)
        competencias = cursor.fetchall()
    conexion.close()
    return competencias

def obtener_eras():
    conexion = conectarMySQL()
    eras = []
    with conexion.cursor() as cursor:
        sql = """
            SELECT 
                era_tipo.id,
                era_tipo.nombre
            FROM 
                era_tipo;
            """
        cursor.execute(sql)
        eras = cursor.fetchall()
    conexion.close()
    return eras

def agregar_era(nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("INSERT INTO era_tipo (nombre) VALUES (%s)", (nombre,))
        conexion.commit()
    conexion.close()

def editar_era(id, nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("UPDATE era_tipo SET nombre=%s WHERE id=%s", (nombre, id))
        conexion.commit()
    conexion.close()

def eliminar_era(id):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("DELETE FROM era_tipo WHERE id=%s", (id,))
        conexion.commit()
    conexion.close()
    
def obtener_ambitos():
    conexion = conectarMySQL()
    ambitos = []
    with conexion.cursor() as cursor:
        sql = """
            SELECT 
                ambito_tipo.id,
                ambito_tipo.nombre
            FROM 
                ambito_tipo;
            """
        cursor.execute(sql)
        ambitos = cursor.fetchall()
    conexion.close()
    return ambitos

def agregar_ambito(nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("INSERT INTO ambito_tipo (nombre) VALUES (%s)", (nombre,))
        conexion.commit()
    conexion.close()

def editar_ambito(id, nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("UPDATE ambito_tipo SET nombre=%s WHERE id=%s", (nombre, id))
        conexion.commit()
    conexion.close()

def eliminar_ambito(id):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("DELETE FROM ambito_tipo WHERE id=%s", (id,))
        conexion.commit()
        
def obtener_competencia_tipos():
    conexion = conectarMySQL()
    competencia_tipos = []
    with conexion.cursor() as cursor:
        sql = """
            SELECT 
                competencia_tipo.id,
                competencia_tipo.nombre
            FROM 
                competencia_tipo;
            """
        cursor.execute(sql)
        competencia_tipos = cursor.fetchall()
    conexion.close()
    return competencia_tipos

def agregar_competencia_tipo(nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("INSERT INTO competencia_tipo (nombre) VALUES (%s)", (nombre,))
        conexion.commit()
    conexion.close()

def editar_competencia_tipo(id, nombre):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("UPDATE competencia_tipo SET nombre=%s WHERE id=%s", (nombre, id))
        conexion.commit()
    conexion.close()

def eliminar_competencia_tipo(id):
    conexion = conectarMySQL()
    with conexion.cursor() as cursor:
        cursor.execute("DELETE FROM competencia_tipo WHERE id=%s", (id,))
        conexion.commit()
    conexion.close()