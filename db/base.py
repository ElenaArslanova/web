from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
import datetime


Base = declarative_base()


class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True)
    login = Column(String)
    password = Column(String)
    email = Column(String)
    visits = Column(Integer)
    last_activity = Column(Integer)

    def __init__(self, login, password, email, visits=None, last_activity=None):
        self.login = login
        self.password = password
        self.email = email
        self.visits = visits
        self.last_activity = last_activity


class Photo(Base):
    __tablename__ = 'photo'
    id = Column(Integer, primary_key=True)
    image_path = Column(String)
    thmb_image_path = Column(String)
    comments = relationship('Comment', backref='photo')

    def __init__(self, id, image_path, thmb_image_path, likes=None):
        self.id = id
        self.image_path = image_path
        self.thmb_image_path = thmb_image_path
        self.likes = likes


class Comment(Base):
    __tablename__ = 'comment'
    id = Column(Integer, primary_key=True)
    photo_id = Column(Integer, ForeignKey('photo.id'))
    user_id = Column(Integer, ForeignKey('user.id'))
    text = Column(String)
    date = Column(DateTime(timezone=True))
    editions = relationship('Edition', backref='edition')

    def __init__(self, photo_id, user_id, text, date):
        self.photo_id = photo_id
        self.user_id = user_id
        self.text = text
        self.date = date


class Edition(Base):
    __tablename__ = 'edition'
    id = Column(Integer, primary_key=True)
    photo_id = Column(Integer, ForeignKey('photo.id'))
    user_id = Column(Integer, ForeignKey('user.id'))
    comment_id = Column(Integer, ForeignKey('comment.id'))
    text = Column(String)
    date = Column(DateTime(timezone=True))

    def __init__(self, photo_id, user_id, comment_id, text, date):
        self.photo_id = photo_id
        self.user_id = user_id
        self.comment_id = comment_id
        self.text = text
        self.date = date


class Visit(Base):
    __tablename__ = 'visit'
    id = Column(Integer, primary_key=True)
    user_logged_in = Column(String)
    activity = Column(String)
    date = Column(DateTime(timezone=True))
    unique = Column(Integer)

    def __init__(self, user_logged_in, activity, date, unique):
        self.user_logged_in = user_logged_in
        self.activity = activity
        self.date = date
        self.unique = unique

# engine = create_engine('sqlite:///data.db')
# Base.metadata.create_all(engine)
