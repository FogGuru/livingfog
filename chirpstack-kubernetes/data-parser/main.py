#!/usr/bin/env python3

import paho.mqtt.client as mqtt
import json
import base64
import argparse
from influxdb import InfluxDBClient
from datetime import datetime

from parser.smart_water import smart_water
from parser.people_counter import people_counter
from parser.wind import wind
from parser.traffic_counter import traffic_counter
from parser.indoor_env import indoor_env


devEUI_file = 'conf/devEUI.json'
with open(devEUI_file) as f:
  devEUI_dict = json.load(f)

location_file = 'conf/location.json'
with open(location_file) as f:
  location_dict = json.load(f)

def get_sensor_type(devEUI):
    sensor_type = None
    for key, value in devEUI_dict.items():
        if devEUI in value:
            sensor_type = key
            break
    return sensor_type

def get_sensor_location(devEUI):
    sensor_location = None
    for key, value in location_dict.items():
        if key == devEUI:
            sensor_location = value
            break
    return sensor_location

def data_parser(payload_dict):
    mqtt_message = {}

    devEUI = payload_dict["devEUI"]

    sensor_location = get_sensor_location(devEUI)
    sensor_type = get_sensor_type(devEUI)
    # print(sensor_type)

    #TODO: define the topic
    if sensor_location != None: 
        topic = sensor_type + "/" + sensor_location
    else:
        print("WARNING: The sensor is not included yet")
        return None, None, None
    
    mqtt_message['SensorID'] = devEUI
    
    if 'data' not in payload_dict.keys():
        print('WARNING: No data in sensor data')
        return None, None, None

    data = payload_dict['data']
    data_hex = base64.b64decode(data).hex()

    if sensor_type == 'smart_water':
        protocol_file = './parser/smart_water.csv'
        mqtt_dict = smart_water(data_hex, protocol_file)
    elif sensor_type == 'smart_water_lon':
        protocol_file = './parser/smart_water_lon.csv'
        mqtt_dict = smart_water(data_hex, protocol_file)  
    elif sensor_type == 'outdoor_env':
        protocol_file = './parser/outdoor_env.csv'
        mqtt_dict = smart_water(data_hex, protocol_file)          
    elif sensor_type == 'people_counter':
        mqtt_dict = people_counter(data_hex)
    elif sensor_type == 'wind':
        mqtt_dict = wind(data_hex)
    elif sensor_type == 'traffic_counter':
        mqtt_dict = traffic_counter(data_hex)
    elif sensor_type == "indoor_env":
        mqtt_dict = indoor_env(data_hex)

    mqtt_message['SensorData'] = mqtt_dict
    

    # Create point for updating influxdb
    influxdb_dict = {}
    tags_dict = {}
    now = datetime.now()
    now_ISO8601 = now.isoformat()

    influxdb_dict["measurement"] = sensor_type
    influxdb_dict["time"] = now_ISO8601
    tags_dict["topic"] = topic
    influxdb_dict["tags"] = tags_dict
    influxdb_dict["fields"] = mqtt_dict    

    # print(topic, mqtt_message, influxdb_dict)
    return topic, mqtt_message, influxdb_dict

def influxdb_update(influxdb_server, influxdb_dict):
    host = influxdb_server
    port = 8086
    user = 'fogguru'
    password = 'FogGuru2020'
    dbname = 'sensor_data'

    # print(host, port, user, password)
    client = InfluxDBClient(host, port, user, password, dbname)
    
    dbs = client.get_list_database()
    
    if dbname not in dbs:
        client.create_database(dbname)
        
    points = []
    points.append(influxdb_dict)
    print("INFO: Write points: {0}".format(points))
    client.write_points(points)
    

# This is the Subscriber
def on_connect(client, userdata, flags, rc):
    print("INFO: Connected with result code " + str(rc))
    client.subscribe("application/#")

def on_message(client, userdata, msg):
    payload = msg.payload.decode() # string
    payload_dict = json.loads(payload) # dict
    print("INFO: Raw data ", payload_dict)

    topic, mqtt_message, influxdb_dict = data_parser(payload_dict)
    
    

    if topic is not None and mqtt_message is not None and bool(mqtt_message['SensorData']): 
        mqtt_message_string = json.dumps(mqtt_message, ensure_ascii=False)
    
        print("INFO: Parsed data", topic, mqtt_message_string)
        client.publish(topic, mqtt_message_string)
        
        if local_influxdb != 'disable' :
            print("INFO: Update influxdb in fog")
            influxdb_update(local_influxdb, influxdb_dict)
        
        if central_influxdb != 'disable':
            print("INFO: Update influxdb in cloud")
            influxdb_update(central_influxdb, influxdb_dict)

    else:
        print("WARNING: Sensor data is wrong")
        
        
        

if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    # Required positional argument
    parser.add_argument('mqtt_server', type=str,
                        help='the ip address of mqtt server')
    parser.add_argument('local_influxdb', type=str,
                        help = 'the ip address of influxdb in a fog cluster')

    parser.add_argument('central_influxdb', type=str, 
                        help='the ip address of central influxdb')
    
    args = parser.parse_args()
    
    global mqtt_server, local_influxdb, central_influxdb
    mqtt_server = args.mqtt_server
    local_influxdb = args.local_influxdb
    central_influxdb = args.central_influxdb
    
    print("INFO: Settings ", mqtt_server, local_influxdb, central_influxdb)
    

    client = mqtt.Client()
    client.username_pw_set(username="fogguru",password="FogGuru2020")
    client.connect(mqtt_server)
    
    client.on_connect = on_connect
    client.on_message = on_message
    
    client.loop_forever()
