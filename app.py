# home -> root
from flask import Flask, jsonify, render_template, request, redirect
# from data import *
from datetime import date, datetime

from controller_db import *

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
    return render_template("index.html",title=basicInfo(title))

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


@app.route("/filtrar_consagraciones", methods=['POST'])
def filtrar_consagraciones():
    era = request.form.get('era')
    ambito = request.form.get('ambito')
    competencia_tipo = request.form.get('competenciaTipo')
    
    resultados = obtener_consagraciones_filtradas(era, ambito, competencia_tipo)
    return jsonify(resultados)
