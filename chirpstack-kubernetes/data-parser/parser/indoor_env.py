#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import struct


def indoor_env(data_hex):
    
    payload_dict = {}
    print(data_hex)
    
    #01 00 93 02 46 03 01 18 04 03 f7 05 00 1d 12 3f 09 c3 2f 3f 44 01 dc c0 
    #06 ce 08 04 82 57 40 d0 9f ab 58 40 eb 55 c6 59 40 f7 40 3c 5a 40 f9 a2 5a
    if len(data_hex) < 90:
        print("WARNING: Wrong data length")
        return payload_dict

    key = data_hex[0:2]
    if key != "01":
        print("Key wrong") 
    # value = int(data_hex[2:6], 16)
    # print(data_hex[10:14], value)
    payload_dict['Temperature'] =  round(struct.unpack('>h', bytes.fromhex(data_hex[2:6]))[0] / 10.0, 2)
    payload_dict['Temperature_unit'] = '°C'
    
    key = data_hex[6:8]
    if key != "02":
        print("Key wrong") 
    # value = int(data_hex[8:10], 16)
    payload_dict['Humidity'] =  struct.unpack('>B', bytes.fromhex(data_hex[8:10]))[0]
    payload_dict['Humidity_unit'] = '%RH'    
    
    key = data_hex[10:12]
    if key != "03":
        print("Key wrong")
    # value = int(data_hex[12:16], 16)
    payload_dict['AmbientLight'] =  struct.unpack('>H', bytes.fromhex(data_hex[12:16]))[0]
    payload_dict['AmbientLight_unit'] = 'lux'  

    key = data_hex[16:18]
    if key != "04":
        print("Key wrong")
    # value = int(data_hex[18:22], 16)
    payload_dict['Pressure'] =  struct.unpack('>H', bytes.fromhex(data_hex[18:22]))[0]
    payload_dict['Pressure_unit'] = 'mbar'  


    key = data_hex[22:24]
    if key != "05":
        print("Key wrong")
    # value = int(data_hex[24:28], 16)
    payload_dict['VolatileOrganicCompounds'] =  struct.unpack('>H', bytes.fromhex(data_hex[24:28]))[0]
    payload_dict['VolatileOrganicCompounds_unit'] = 'IAQ'  
    
    key = data_hex[28:30]
    if key != "12":
        print("Key wrong")
    payload_dict['bVOC'] =  round(struct.unpack('>f', bytes.fromhex(data_hex[30:38]))[0], 2)
    payload_dict['bVOC_unit'] = 'ppm'    

    key = data_hex[38:40]
    if key != "3f":
        print("Key wrong")
    payload_dict['CO2e'] =  round(struct.unpack('>f', bytes.fromhex(data_hex[40:48]))[0], 2)
    payload_dict['CO2e_unit'] = 'ppm'       


    key = data_hex[48:50]
    if key != "06":
        print("Key wrong")
    # value = int(data_hex[50:52], 16)
    payload_dict['Oxygen'] =  struct.unpack('>B', bytes.fromhex(data_hex[50:52]))[0]
    payload_dict['Oxygen_unit'] = '%'  


    key = data_hex[52:54]
    if key != "08":
        print("Key wrong")
    # value = int(data_hex[54:58], 16)
    payload_dict['CarbonDioxide'] =  struct.unpack('>H', bytes.fromhex(data_hex[54:58]))[0]
    payload_dict['CarbonDioxide_unit'] = 'CarbonDioxide'


    key = data_hex[58:60]
    if key != "57":
        print("Key wrong")
    payload_dict['PM1.0'] =  round(struct.unpack('>f', bytes.fromhex(data_hex[60:68]))[0], 2)
    payload_dict['PM1.0_unit'] = 'µg/m³'

    key = data_hex[68:70]
    if key != "58":
        print("Key wrong")
    # value = int(data_hex[70:78], 16)
    payload_dict['PM2.5'] =  round(struct.unpack('>f', bytes.fromhex(data_hex[70:78]))[0], 2)
    payload_dict['PM2.5_unit'] = 'µg/m³'

    key = data_hex[78:80]
    if key != "59":
        print("Key wrong")
    payload_dict['PM4.0'] =  round(struct.unpack('>f', bytes.fromhex(data_hex[80:88]))[0], 2)
    payload_dict['PM4.0_unit'] = 'µg/m³'
 
    key = data_hex[88:90]
    if key != "5a":
        print("Key wrong")
    payload_dict['PM10.5'] =  round(struct.unpack('>f', bytes.fromhex(data_hex[90:98]))[0], 2)
    payload_dict['PM10.5_unit'] = 'µg/m³'

    return payload_dict