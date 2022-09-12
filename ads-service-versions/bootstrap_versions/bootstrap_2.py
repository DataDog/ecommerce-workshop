from flask import Flask
from models import Advertisement, db
import ldclient
from ldclient.config import Config

import os
DB_USERNAME = os.environ['POSTGRES_USER']
DB_PASSWORD = os.environ['POSTGRES_PASSWORD']
DB_HOST = os.environ['POSTGRES_HOST']
LD_API_KEY = os.environ['LD_API_KEY']

def create_app():
    """Create a Flask application"""
    app = Flask(__name__)
    #app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://' + DB_USERNAME + ':' + DB_PASSWORD + '@' + DB_HOST + '/' + DB_USERNAME
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)
    initialize_database(app, db)
    app.ldclient = ldclient.client.LDClient(Config(LD_API_KEY), start_wait=8)
    app.logger.info(app.ldclient)
    return app


def initialize_database(app, db):
    """Drop and restore database in a consistent state"""
    with app.app_context():
        db.drop_all()
        db.create_all()
        ad1 = Advertisement('Version1', '/t/clothing', 10.1, '1.png')
        ad2 = Advertisement('Version2', '/t/clothing', 10.1, '2.png')
        ad3 = Advertisement('Version3', '/t/clothing', 10.1, '3.png')
        ad4 = Advertisement('Version4', '/t/clothing', 10.1, '4.png')
        ad5 = Advertisement('Version5', '/t/clothing', 10.1, '5.png')
        ad6 = Advertisement('Version1', '/t/clothing', 10.1, '6.png')
        ad7 = Advertisement('Version2', '/t/clothing', 15.1, '7.png')
        ad8 = Advertisement('Version3', '/t/clothing', 15.1, '8.png')
        ad9 = Advertisement('Version4', '/t/clothing', 15.1, '9.png')
        ad10 = Advertisement('Version5', '/t/clothing', 15.1, '10.png')
        ad11= Advertisement('Version6', '/t/clothing', 15.1, '11.png')
        ad12 = Advertisement('Version7', '/t/clothing', 2.0, '12.png')
        ad13 = Advertisement('Version8', '/t/clothing', 2.0, '13.png')
        db.session.add(ad1)
        db.session.add(ad2)
        db.session.add(ad3)
        db.session.add(ad4)
        db.session.add(ad5)
        db.session.add(ad6)
        db.session.add(ad7)
        db.session.add(ad8)
        db.session.add(ad9)
        db.session.add(ad10)
        db.session.add(ad11)
        db.session.add(ad12)
        db.session.add(ad13)
        db.session.commit()
