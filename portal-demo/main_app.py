#!/usr/bin/env python
import bottle
import os
import requests

# Required - throws a KeyError if not found
asp_dns_name = os.environ['ASP_DNS_NAME']

app = bottle.app()

@bottle.route('/')
def root_index():
    return bottle.template('index')

@bottle.route('/flightinfo')
def flight_info():
    response = requests.get('http://{}:8080/asp/api/flight/info'.format(asp_dns_name)).json()
    # gps_info is a sub-dictionary - flatten it into the main data
    gps_info = dict.fromkeys(response[u'gpsData'])
    del response[u'gpsData']
    response.update(gps_info)
    return bottle.template('dict_table', data = response, title = 'Flight Info')

@bottle.route('/systemstatus')
def system_status():
    response = requests.get('http://{}:8080/asp/api/flight/systemStatus'.format(asp_dns_name))
    return bottle.template('dict_table', data = response.json(), title = 'System Status')

@bottle.route('/servicestatus')
def service_status():
    response = requests.get('http://{}:8080/asp/api/config/serviceStatus'.format(asp_dns_name))
    return bottle.template('dict_table', data = response.json(), title = 'Service Status')

@bottle.route('/configall')
def config_all():
    response = requests.get('http://{}:8080/asp/api/config/all'.format(asp_dns_name))
    return bottle.template('dict_table', data = response.json(), title = 'Config All')

@bottle.route('/network')
def network():
    response = requests.get('http://{}:8080/asp/api/network/info'.format(asp_dns_name))
    return bottle.template('dict_table', data = response.json(), title = 'Network Info')

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
    bottle.run(app=app,host=asp_dns_name,port=8090)

