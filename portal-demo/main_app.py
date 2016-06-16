#!/usr/bin/env python
import bottle
import subprocess
import os


ip_addr = "0.0.0.0"

app = bottle.app()

@bottle.route('/')
def root_index():
    return bottle.template('index',ip_addr = ip_addr)

@bottle.route('/json')
def json_reply():
    heads = bottle.request.headers
    bottle.response.content_type = 'application/json'

    response = {'headers':dict(heads),
            'environment':dict(os.environ),
            'response':dict(bottle.response.headers)}
    return response

if __name__=='__main__':
    bottle.debug(True)
    bottle.run(app=app,host='localhost',port=8080)

