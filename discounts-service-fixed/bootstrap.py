from flask import Flask
from models import Discount, DiscountType, Influencer, db

import random
import os
import sys
import json
import names

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import words

def initialize_database(app, db):
    """Drop and restore database in a consistent state"""
    with app.app_context():
        db.drop_all()
        db.create_all()

        for i in range(100):
            discount_type = DiscountType(words.get_random(),
                                         'price * %f' % random.random(),
                                         Influencer(names.get_full_name()))
            discount_name = words.get_random(random.randint(2,4))
            discount = Discount(discount_name,
                                words.get_random().upper(),
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
