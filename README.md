# python-worksonmymachine
Repositiorio del curso Full Stack Python, 1er cuatrimestre 2024 - Codo a codo

Grupo 12 - WorksOnMyMachine

Web app que compara consagraciones de equipos de fútbol en Argentina. A nivel backend expone a modo de api rest servicios que permiten CRUD de equipos y torneos.

Se utilizó el framework Flask, base de datos MySQL y Bootstrap. Se puede acceder a la web app en el siguiente enlace: https://worksonmymachine.herokuapp.com/

Utiliza formspree para envío de emails a través del formulario de contacto en el footer


----------------
## Requisitos de instalación
----------------
1. Instalar Python 3.10.11
2. Instalar virtualenv
3. Generar virtualenv con requirements.txt -> python -m venv .venv -> .venv\Scripts\activate
4. Instalar pymysql -> pip install pymysql
5. Instalar Flask -> pip install Flask
6. Generar una base de datos en MySQL local llamada afa-lens
7. Importar en la base de datos el script database.sql
8. Ejecutar el archivo app.py con el comando python app.py
