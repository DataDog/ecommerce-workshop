from flask import Flask
from models import Discount, db

import os
DB_USERNAME = os.environ['POSTGRES_USER']
DB_PASSWORD = os.environ['POSTGRES_PASSWORD']


def create_app():
    """Create a Flask application"""
    app = Flask(__name__)
    #app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://' + DB_USERNAME + ':' + DB_PASSWORD + '@' + 'db/' + DB_USERNAME
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)
    initialize_database(app, db)
    return app


def initialize_database(app, db):
    """Drop and restore database in a consistent state"""
    with app.app_context():
        db.drop_all()
        db.create_all()
        first_discount = Discount('Black Friday', 'BFRIDAY', 5.1)
        second_discount = Discount('SWEET SUNDAY', 'OFF', 300.1)
        third_discount = Discount('Monday Funday', 'PARTY', 5242.1)
        db.session.add(first_discount)
        db.session.add(second_discount)
        db.session.add(third_discount)
        db.session.commit()