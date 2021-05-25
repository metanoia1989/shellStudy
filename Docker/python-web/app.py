#!/usr/bin/env python3
#-*- coding: utf-8 -*-

from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return f'该页面已被访问 {count}次。\n'

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)