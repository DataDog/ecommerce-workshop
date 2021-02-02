from sqlalchemy.orm import Session

from . import models, schemas

import names, random
import json

with open('words.json') as f:
  words = json.load(f)

def get_discounts(db: Session):
    return db.query(models.Discount).all()

def populate_database(db: Session):
    for i in range(100):
        influencer = models.Influencer(name=names.get_full_name())
        db.add(influencer)
        db.commit()
        discount_type = models.DiscountType(name=random.choice(words),
                                            discount_query=f"price * {random.random()}",
                                            influencer_id=influencer.id)
        db.add(discount_type)
        db.commit()
        discount_name = random.choice(words)
        for i in range(random.randint(1,3)):
            discount_name += ' ' + random.choice(words)
        discount = models.Discount(name=discount_name,
                                   code=random.choice(words).upper(),
                                   value=int(random.randrange(1,100) * random.random()),
                                   discount_type_id=discount_type.id)
        db.add(discount)
        db.commit()
        db.refresh(discount)
    return