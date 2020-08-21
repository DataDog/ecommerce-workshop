import base64
import io
import json
import random
import requests
import time

from random_word import RandomWords

from flask import Flask, Response, jsonify, safe_join, send_file, send_from_directory
from flask import request as flask_request

from bootstrap import create_app
from models import Advertisement, db

r = RandomWords()

app = create_app()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/')
def hello():
    app.logger.info("home url for ads called")
    return Response({'Hello from Advertisements!': 'world'}, mimetype='application/json')

@app.route('/banners/<path:banner>')
def banner_image(banner):
    animated = flask_request.args.get('animated')

    if animated:
        filename = safe_join("ads", banner)
        with open(filename, "rb") as f:
            img_bytes = f.read()
            b64encode_img_bytes = base64.b64encode(img_bytes)

        payload = {
            "spots": 20,
            "image": b64encode_img_bytes.decode("utf-8")
        }
        response = requests.post('http://bling-bling:5003/place-bling', json=payload)
        animated_img_bytes = base64.b64decode(response.text)

        gif_file_object = io.BytesIO(animated_img_bytes)
        gif_file_object.seek(0)
        return send_file(gif_file_object, mimetype='image/gif')
    else:
        app.logger.info(f"attempting to grab banner at {banner}")
        img_file = send_from_directory('ads', banner)
        return img_file

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
        advertisements = Advertisement.query.all()
        app.logger.info(f"Total advertisements available: {len(advertisements)}")
        # adding a half sleep to test something
        time.sleep(2.5)
        return jsonify([b.serialize() for b in advertisements])
    elif flask_request.method == 'POST':
        # create a new advertisement with random name and value
        advertisements_count = len(Advertisement.query.all())
        new_advertisement = Advertisement('Advertisement ' + str(discounts_count + 1), 
                                '/',
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