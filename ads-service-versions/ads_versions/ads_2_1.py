import requests
import random
import time
import uuid

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
        
        user = {
            "key": uuid.uuid4(),
            "custom": {
                "platform": flask_request.user_agent.platform,
                "browser": flask_request.user_agent.browser,
                "language": flask_request.user_agent.language,
                "unparsed": flask_request.user_agent.string
            }
        }

        try:
            enableNewAdEngine = app.ldclient.variation("enable-new-ad-engine", user, False)
            advertisements = Advertisement.query.all()
            if enableNewAdEngine: 
                return_ads = [ad for ad in advertisements if ad.weight > 15.0 ]
                selected_ad = random.choice(return_ads)
                return selected_ad.serialize()
            else: 
                return_ads = [ad for ad in advertisements if ad.weight > 10.0 and ad.weight < 15.0]
                selected_ad = random.choice(return_ads)
                return selected_ad.serialize()

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