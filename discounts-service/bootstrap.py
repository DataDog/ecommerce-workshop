from flask import Flask
from models import Discount, DiscountType, Influencer, db
import names

import random
import os

import json

with open('words.json') as f:
  words = json.load(f)


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

        for i in range(100):
            discount_type = DiscountType(random.choice(words),
                                         'price * %f' % random.random(),
                                         Influencer(names.get_full_name()))
            discount_name = random.choice(words)
            for i in range(random.randint(1,3)):
                discount_name += ' ' + random.choice(words)
            discount = Discount(discount_name,
                                random.choice(words).upper(),
                                random.randrange(1,100) * random.random(),
                                discount_type)
            db.session.add(discount)

        first_discount_type = DiscountType('Save with Sherry', 
                                           'price * .8',
                                           Influencer('Sherry'))
        second_discount_type = DiscountType('Sunday Savings', 
                                           'price * .9',
                                           None)
        third_discount_type = DiscountType('Monday Funday',
                                           'price * .95',
                                           None)
        first_discount = Discount('Black Friday', 
                                  'BFRIDAY', 
                                  5.1,
                                  first_discount_type)

        second_discount = Discount('SWEET SUNDAY', 
                                   'OFF',
                                   300.1,
                                   second_discount_type)
        third_discount = Discount('Monday Funday', 
                                  'PARTY', 
                                  542.1,
                                  third_discount_type)
        db.session.add(first_discount)
        db.session.add(second_discount)
        db.session.add(third_discount)
        db.session.commit()
