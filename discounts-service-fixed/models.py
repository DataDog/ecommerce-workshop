from flask_sqlalchemy import SQLAlchemy
import datetime

db = SQLAlchemy()

class Influencer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
    discount_types = db.relationship("DiscountType", backref="influencer", lazy=True)
    
    def __init__(self, name):
        self.name = name

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'discounts': len(self.discount_types)
        }

class DiscountType(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
    influencer_id = db.Column(db.Integer, db.ForeignKey('influencer.id'), nullable=True)
    discount_query = db.Column(db.String(128))
    discounts = db.relationship('Discount', backref='discount_type', lazy=True)

    def __init__(self, name, discount_query, influencer):
        self.name = name
        self.discount_query = discount_query
        self.influencer = influencer

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'discount_query': self.discount_query
        }
    

class Discount(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
    code = db.Column(db.String(64))
    value = db.Column(db.Integer)
    discount_type_id = db.Column(db.Integer, db.ForeignKey('discount_type.id'), nullable=False)

    def __init__(self, name, code, value, discount_type):
        self.name = name
        self.code = code
        self.value = value
        self.discount_type = discount_type
    
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'code': self.code,
            'value': self.value,
            'discount_type': self.discount_type.serialize()
        }


    