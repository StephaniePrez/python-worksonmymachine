# python-worksonmymachine
Repositiorio del curso Full Stack Python, 1er cuatrimestre 2024 - Codo a codo

Equipo 12 - WorksOnMyMachine

Esta Web app tiene como finalidad contar todas las consagraciones de los equipos que en este momento se encuentran en la primera división del fútbol argentino. Las mismas se pueden filtrar por:
- Eras: profesional / amateur / ambas
- Ámbitos: nacional / internacional / ambos
- Tipos de competencia: torneo / copa / ambos

En esta primera etapa los datos que hemos recopilado son genéricos por cada uno de esos tipos. Mas adelante la idea es poder filtrar de manera anidada por cada una de las copas y torneos existentes. Asimismo iremos agregando datos que nos resulten relevantes de cada equipo o competencia, que sean útiles para determinar cuales son los grandes equipos del fútbol argentino del presente.

---------------------------------------

Web generada con HTML, CSS y JS.

A nivel backend expone a modo de api rest servicios que permiten CRUD de equipos y torneos.

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
