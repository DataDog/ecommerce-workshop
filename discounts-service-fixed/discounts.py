import requests
import random
import time
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import words

from flask import Flask, Response, jsonify
from flask import request as flask_request
from flask_cors import CORS

from sqlalchemy.orm import joinedload

from bootstrap import create_app
from models import Discount, DiscountType, db

app = create_app()
CORS(app)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/')
def hello():
    return Response({'Hello from Discounts!': 'world'}, mimetype='application/json')

@app.route('/discount', methods=['GET', 'POST'])
def status():
    if flask_request.method == 'GET':
       
        try:
          discounts = Discount.query.all()
          app.logger.info(f"Discounts available: {len(discounts)}")

          influencer_count = 0
          for discount in discounts:
              if discount.discount_type.influencer:
                  influencer_count += 1
          app.logger.info(f"Total of {influencer_count} influencer specific discounts as of this request")
        
          return jsonify([b.serialize() for b in discounts])

        except:
          app.logger.error("An error occurred while getting discounts.")
          err = jsonify({'error': 'Internal Server Error'})
          err.status_code = 500
          return err

    elif flask_request.method == 'POST':

        try:
            # create a new discount with random name and value
            discounts_count = len(Discount.query.all())
            new_discount_type = DiscountType('Random Savings',
                                             'price * .9',
                                             None)
            new_discount = Discount('Discount ' + str(discounts_count + 1),
                                    words.get_random(random.randint(2,4)),
                                    random.randint(10,500),
                                    new_discount_type)
            app.logger.info(f"Adding discount {new_discount}")
            db.session.add(new_discount)
            db.session.commit()
            discounts = Discount.query.all()

            return jsonify([b.serialize() for b in discounts])

        except:
          app.logger.error("An error occurred while creating a new discount.")
          err = jsonify({'error': 'Internal Server Error'})
          err.status_code = 500
          return err

    else:
        err = jsonify({'error': 'Invalid request method'})
        err.status_code = 405
        return err