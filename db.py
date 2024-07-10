# instalar pymysql -> pip install pymysql
# importar pymysql / SQLachemy / dbmysql
import pymysql

# conectar con el servidro MySQL
def conectarMySQL():
    # datos sensibles -> variables de entorno
    host="localhost"
    user="root"
    clave=""
    db="afa-lens"
    return pymysql.connect(host=host,user=user,password=clave,database=db)