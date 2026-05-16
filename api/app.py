from flask import Flask, jsonify, request
from flask_cors import CORS
from datatools import datatime
import os
from dotenv import load_dotenv
from yfinance import Ticker
import pandas as pd
import numpy as np

#Cargar variables de entorno
load_dotenv()

#directorio

base_dir = os.path.dirname(os.path.abspath(__file__))

#inicializar la aplicación Flask
app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'dev_my_secret_key')

#configurar la db
db_path = os.path.join(base_dir, 'instance', 'financel.db')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL', f'sqlite:///{db_path}')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

#habilitar CORS
CORS(app)