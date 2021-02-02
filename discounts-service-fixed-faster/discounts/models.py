from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship

import datetime
from .database import Base

class Influencer(Base):
    __tablename__ = 'influencers'
    id = Column(Integer, primary_key=True)
    name = Column(String(128))
    discount_types = relationship("DiscountType", backref="influencers", lazy=True)

class DiscountType(Base):
    __tablename__ = 'discount_types'
    id = Column(Integer, primary_key=True)
    name = Column(String(128))
    influencer_id = Column(Integer, ForeignKey('influencers.id'), nullable=True)
    discount_query = Column(String(128))
    discounts = relationship('Discount', backref='discount_types', lazy=True)
    
class Discount(Base):
    __tablename__ = 'discounts'
    id = Column(Integer, primary_key=True)
    name = Column(String(128))
    code = Column(String(64))
    value = Column(Integer)
    discount_type_id = Column(Integer, ForeignKey('discount_types.id'), nullable=False)
    