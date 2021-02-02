from typing import List

from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session

from . import crud, models, schemas
from .database import SessionLocal, engine

import requests
import random
import time

from random_word import RandomWords

models.Base.metadata.create_all(bind=engine)
db = SessionLocal()
crud.populate_database(db)
db.close()
app = FastAPI()


r = RandomWords()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get('/')
def hello():
    return {'Hello from Discounts!': 'world'}

@app.get('/discount', response_model=List[schemas.Discount])
def read_discounts(db: Session = Depends(get_db)):
    discounts = crud.get_discounts(db=db)
    #app.logger.info(f"Discounts available: {len(discounts)}")
    #influencer_count = 0
    #for discount in discounts:
    #    if discount.discount_type.influencer:
    #        influencer_count += 1
    #app.logger.info(f"Total of {influencer_count} influencer specific discounts as of this request")
    return discounts