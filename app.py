# home -> root
from flask import Flask, jsonify, render_template, request, redirect
# from data import *
from datetime import date, datetime

from controller_db import *

print("Starting Flask application...")

app = Flask(__name__)

def basicInfo(getTitle):
    #Día actual
    today = date.today()
    #Fecha actual
    now = datetime.now()
    # Seccion
    title = getTitle
    return [title, today.strftime('%Y'), now]

@app.route("/")
def home():
    title="Home"
    eras = obtener_eras()
    ambitos = obtener_ambitos()
    tiposCompetencia = obtener_competencia_tipos()
    return render_template("index.html",title=basicInfo(title), eras=eras, ambitos=ambitos, tiposCompetencia=tiposCompetencia)

@app.route('/#copas')
def copas():
    title = "Copas"
    return render_template("copas.html", title=basicInfo(title))

@app.route("/trofeos")
def trofeos():
    title = "Trofeos"
    equipos = obtener_hinchas()
    return render_template("trofeos.html", title=basicInfo(title), equipos=equipos)

@app.route("/faqs")
def faqs():
    title = "Faqs"
    return render_template("faqs.html", title=basicInfo(title))

@app.route("/panel")
def panel():
    title = "Afa Lens Panel de control"
    equipos = obtener_equipos()
    competencias = obtener_competencias()
    eras = obtener_eras()
    ambitos = obtener_ambitos()
    tiposCompetencia = obtener_competencia_tipos()
    return render_template("panel.html", title=basicInfo(title), equipos=equipos, competencias=competencias, eras=eras, ambitos=ambitos, tiposCompetencia=tiposCompetencia)

@app.route('/agregar_equipo', methods=['POST'])
def agregar_equipo_route():
    nombre = request.form['nombreEquipo']
    agregar_equipo(nombre)
    return redirect(('/panel'))

@app.route('/editar_equipo/<int:id>', methods=['POST'])
def editar_equipo_route(id):
    nombre = request.form['nombreEquipo']
    editar_equipo(id, nombre)
    return redirect(('/panel'))

@app.route('/eliminar_equipo/<int:id>')
def eliminar_equipo_route(id):
    eliminar_equipo(id)
    return redirect(('/panel'))

@app.route('/agregar_era', methods=['POST'])
def agregar_era_route():
    nombre = request.form['nombreEra']
    agregar_era(nombre)
    return redirect(('/panel'))

@app.route('/editar_era/<int:id>', methods=['POST'])
def editar_era_route(id):
    nombre = request.form['nombreEra']
    editar_era(id, nombre)
    return redirect(('/panel'))

@app.route('/eliminar_era/<int:id>')
def eliminar_era_route(id):
    eliminar_era(id)
    return redirect(('/panel'))

@app.route('/agregar_ambito', methods=['POST'])
def agregar_ambito_route():
    nombre = request.form['nombreAmbito']
    agregar_ambito(nombre)
    return redirect(('/panel'))

@app.route('/editar_ambito/<int:id>', methods=['POST'])
def editar_ambito_route(id):
    nombre = request.form['nombreAmbito']
    editar_ambito(id, nombre)
    return redirect(('/panel'))

@app.route('/eliminar_ambito/<int:id>')
def eliminar_ambito_route(id):
    eliminar_ambito(id)
    return redirect(('/panel'))

@app.route('/agregar_competencia_tipo', methods=['POST'])
def agregar_competencia_tipo_route():
    nombre = request.form['nombreTipoCompetencia']
    agregar_competencia_tipo(nombre)
    return redirect(('/panel'))

@app.route('/editar_competencia_tipo/<int:id>', methods=['POST'])
def editar_competencia_tipo_route(id):
    nombre = request.form['nombreTipoCompetencia']
    editar_competencia_tipo(id, nombre)
    return redirect(('/panel'))

@app.route('/eliminar_competencia_tipo/<int:id>')
def eliminar_competencia_tipo_route(id):
    eliminar_competencia_tipo(id)
    return redirect(('/panel'))

@app.route("/filtrar_consagraciones", methods=['POST'])
def filtrar_consagraciones():
    era = request.form.get('era')
    ambito = request.form.get('ambito')
    competencia_tipo = request.form.get('competenciaTipo')
    
    resultados = obtener_consagraciones_filtradas(era, ambito, competencia_tipo)
    return jsonify(resultados)

if __name__ == '__main__':
    app.run(debug=True)