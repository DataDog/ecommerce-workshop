import requests
import random
import time

from random_word import RandomWords

from flask import Flask, Response, jsonify
from flask import request as flask_request

from bootstrap import create_app
from models import Advertisement, db

r = RandomWords()

app = create_app()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/')
def hello():
    return Response({'Hello from Advertisements!': 'world'}, mimetype='application/json')

@app.route('/ads', methods=['GET', 'POST'])
def status():
    if flask_request.method == 'GET':
        advertisements = Advertisement.query.all()
        app.logger.info(f"Advertisements available: {len(advertisements)}")
        # adding a half sleep to test something
        time.sleep(2.5)
        return jsonify([b.serialize() for b in advertisements])
    elif flask_request.method == 'POST':
        # create a new advertisement with random name and value
        advertisements_count = len(Advertisement.query.all())
        new_advertisement = Advertisement('Advertisement ' + str(discounts_count + 1), 
                                'https://www.google.com/',
                                random.randint(10,500))
        app.logger.info(f"Adding advertisement {new_advertisement}")
        db.session.add(new_advertisement)
        db.session.commit()
        advertisements = Advertisement.query.all()

        # adding a half sleep to test something
        time.sleep(2.5)
        return jsonify([b.serialize() for b in advertisements])
    else:
        err = jsonify({'error': 'Invalid request method'})
        err.status_code = 405
        return err