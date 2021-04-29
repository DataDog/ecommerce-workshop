from flask_sqlalchemy import SQLAlchemy
import datetime

db = SQLAlchemy()

class Advertisement(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
    url = db.Column(db.String(64))
    weight = db.Column(db.Float())
    path = db.Column(db.String(128))

    def __init__(self, name, url, weight, path):
        self.name = name
        self.url = url
        self.weight = weight
        self.path = path
    
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'url': self.url,
            'weight': self.weight,
            'path': self.path
        }


    