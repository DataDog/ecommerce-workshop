from flask import Flask
from models import Advertisement, db

def initialize_database(app, db):
    """Drop and restore database in a consistent state"""
    with app.app_context():
        db.drop_all()
        db.create_all()
        ad1 = Advertisement('Version11', '/t/clothing', 1.0, '1.png')
        ad2 = Advertisement('Version12', '/t/clothing', 1.0, '2.png')
        ad3 = Advertisement('Version13', '/t/clothing', 1.0, '3.png')
        ad4 = Advertisement('Version14', '/t/clothing', 1.0, '4.png')
        ad5 = Advertisement('Version15', '/t/clothing', 1.0, '5.png')
        ad6 = Advertisement('Version21', '/t/clothing', 2.0, '6.png')
        ad7 = Advertisement('Version22', '/t/clothing', 2.0, '7.png')
        ad8 = Advertisement('Version23', '/t/clothing', 2.0, '8.png')
        ad9 = Advertisement('Version24', '/t/clothing', 2.0, '9.png')
        ad10 = Advertisement('Version25', '/t/clothing', 2.0, '10.png')
        ad11 = Advertisement('Version26', '/t/clothing', 2.0, '11.png')
        db.session.add(ad1)
        db.session.add(ad2)
        db.session.add(ad3)
        db.session.add(ad4)
        db.session.add(ad5)
        db.session.add(ad6)
        db.session.add(ad7)
        db.session.add(ad8)
        db.session.add(ad9)
        db.session.add(ad10)
        db.session.add(ad11)
        db.session.commit()
