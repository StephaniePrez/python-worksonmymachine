# home -> root
from flask import Flask, render_template, request, redirect
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
    return render_template("trofeos.html", title=basicInfo(title))

@app.route("/faqs")
def faqs():
    title = "Faqs"
    return render_template("faqs.html", title=basicInfo(title))
