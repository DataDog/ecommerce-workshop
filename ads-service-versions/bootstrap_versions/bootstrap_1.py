from flask import Flask
from models import Advertisement, db

import os
DB_USERNAME = os.environ['POSTGRES_USER']
DB_PASSWORD = os.environ['POSTGRES_PASSWORD']
DB_HOST = os.environ['POSTGRES_HOST']


def create_app():
    """Create a Flask application"""
    app = Flask(__name__)
    #app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://' + DB_USERNAME + ':' + DB_PASSWORD + '@' + DB_HOST + '/' + DB_USERNAME
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)
    initialize_database(app, db)
    return app


def initialize_database(app, db):
    """Drop and restore database in a consistent state"""
    with app.app_context():
        db.drop_all()
        db.create_all()
        ad1 = Advertisement('Version1', '/t/clothing', 15.1, '1.png')
        ad2 = Advertisement('Version2', '/t/clothing', 15.1, '2.png')
        ad3 = Advertisement('Version3', '/t/clothing', 15.1, '3.png')
        ad4 = Advertisement('Version4', '/t/clothing', 15.1, '4.png')
        ad5 = Advertisement('Version5', '/t/clothing', 15.1, '5.png')
        db.session.add(ad1)
        db.session.add(ad2)
        db.session.add(ad3)
        db.session.add(ad4)
        db.session.add(ad5)
        db.session.commit()
