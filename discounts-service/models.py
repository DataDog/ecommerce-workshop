from flask_sqlalchemy import SQLAlchemy
import datetime

db = SQLAlchemy()

class Discount(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
    code = db.Column(db.String(64))
    value = db.Column(db.Float())

    def __init__(self, name, code, value):
        self.name = name
        self.code = code
        self.value = value
    
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'code': self.code,
            'value': self.value
        }


    