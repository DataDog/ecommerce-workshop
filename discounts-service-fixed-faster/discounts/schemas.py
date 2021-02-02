from typing import List, Optional
from pydantic import BaseModel

class DiscountBase(BaseModel):
    name: str
    code: str
    value: int

class DiscountCreate(DiscountBase):
    pass

class Discount(DiscountBase):
    id: int
    discount_type_id: int

    class Config:
        orm_mode = True

class DiscountTypeBase(BaseModel):
    name: str
    discount_query: str

class DiscountTypeCreate(DiscountTypeBase):
    pass

class DiscountType(DiscountTypeBase):
    id: int
    influencer_id: int
    discounts: List[Discount] = []

    class Config:
        orm_mode = True

class InfluencerBase(BaseModel):
    name: str

class InfluencerCreate(InfluencerBase):
    pass

class Influencer(InfluencerBase):
    id: int
    discount_types: List[DiscountType] = []

    class Config:
        orm_mode = True