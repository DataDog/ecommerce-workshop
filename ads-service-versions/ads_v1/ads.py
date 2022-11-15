import requests
import random

from flask import Flask, Response, jsonify, send_from_directory
from flask import request as flask_request
from flask_cors import CORS

from bootstrap import create_app
from models import Advertisement, db

app = create_app()
CORS(app)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/')
def hello():
    app.logger.info("home url for ads called")
    return Response({'Hello from Advertisements!': 'world'}, mimetype='application/json')

@app.route('/banners/<path:banner>')
def banner_image(banner):
    app.logger.info(f"attempting to grab banner at {banner}")
    return send_from_directory('ads', banner)

@app.route('/weighted-banners/<float:weight>')
def weighted_image(weight):
    app.logger.info(f"attempting to grab banner weight of less than {weight}")
    advertisements = Advertisement.query.all()
    for ad in advertisements:
        if ad.weight < weight:
            return jsonify(ad.serialize())

@app.route('/ads', methods=['GET', 'POST'])
def status():
    if flask_request.method == 'GET':

        try:
            advertisements = Advertisement.query.all()
            return_ads = [ad for ad in advertisements if ad.weight >= 1.0 and ad.weight < 2.0]
            for ad in return_ads:
                app.logger.info(f"Ad: {ad.name} weight: {ad.weight}")
            return jsonify([b.serialize() for b in return_ads])

        except:
            app.logger.error("An error occurred while getting ad.")
            err = jsonify({'error': 'Internal Server Error'})
            err.status_code = 500
            return err

    elif flask_request.method == 'POST':

        try:
            # create a new advertisement with random name and value
            advertisements_count = len(Advertisement.query.all())
            new_advertisement = Advertisement('Advertisement ' + str(discounts_count + 1),
                                    '/',
                                    random.randint(10,500))
            app.logger.info(f"Adding advertisement {new_advertisement}")
            db.session.add(new_advertisement)
            db.session.commit()
            advertisements = Advertisement.query.all()

            return jsonify([b.serialize() for b in advertisements])

        except:

            app.logger.error("An error occurred while creating a new ad.")
            err = jsonify({'error': 'Internal Server Error'})
            err.status_code = 500
            return err

    else:
        err = jsonify({'error': 'Invalid request method'})
        err.status_code = 405
        return err