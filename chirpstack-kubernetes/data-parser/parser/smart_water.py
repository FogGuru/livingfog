# from csv import DictReader

import pandas as pd
import struct



# 1 byte: sequence number
# 1 byte: length
# payload
# with open(protocol_file, encoding="utf-8") as read_obj:
#     # pass the file object to DictReader() to get the DictReader object
#     csv_dict_reader = DictReader(read_obj)
#     # iterate over each line as a ordered dictionary
#     # for row in csv_dict_reader:
#     #     # row variable is a dictionary that represents a row in csv
#     #     print(row)



# print(df['Sensor'], df['SENSORIDBinary'])


def get_sensor_data(sensor_id, df):
    sensor_name = df['Sensor'][df['SENSORIDBinary'] == sensor_id].values[0]
    data_size = df['BinarySizeperField'][df['SENSORIDBinary'] == sensor_id].values[0]
    data_type = df['BinaryTypeofvariable'][df['SENSORIDBinary'] == sensor_id].values[0]
    data_precision = int(df['DefaultDecimalPrecision'][df['SENSORIDBinary'] == sensor_id].values[0])
    data_unit = str(df['Unit'][df['SENSORIDBinary'] == sensor_id].values[0])

    return sensor_name, data_size, data_type, data_precision, data_unit


def to_little(val):
  little_hex = bytearray.fromhex(val)
  little_hex.reverse()
  # print("Byte array format:", little_hex)

  str_little = ''.join(format(x, '02x') for x in little_hex)

  return str_little


def smart_water(data_hex, protocol_file):

    df = pd.read_csv(protocol_file)
    
    payload_dict = {}

    index_start = 0
    index_end = index_start + 2 * 1
    sequence_number = int(data_hex[index_start:index_end], 16)
    payload_dict['SequenceNumber'] = sequence_number

    index_start = index_end
    index_end = index_start + 2 * 1
    frame_length = int(data_hex[index_start:index_end], 16)
    payload_dict['Length'] = frame_length

    while index_end < 2*frame_length:

        index_start = index_end
        index_end = index_start + 2 * 1

        sensor_id = int(data_hex[index_start:index_end], 16)
        sensor_name, data_size, data_type, data_precision, data_unit = get_sensor_data(sensor_id, df)

        index_start = index_end
        index_end = index_start + 2 * data_size

        # print(index_start, index_end)
        # print(data_type)
        if data_type == 'uint8_t':
            sensor_value = struct.unpack('<B', bytes.fromhex(data_hex[index_start:index_end]))[0]
            #int(data_hex[index_start:index_end], 16)
        elif data_type == 'uint16_t':
            sensor_value = struct.unpack('<H', bytes.fromhex(data_hex[index_start:index_end]))[0]
            # int(to_little(data_hex[index_start:index_end]), 16)
        elif data_type == 'float':
            sensor_value = round(struct.unpack('<f', bytes.fromhex(data_hex[index_start:index_end]))[0], data_precision)
            # print(type(sensor_value))
        # print(sensor_name, sensor_value)

        # print(type(data_unit), data_unit, len(data_unit))
        # if data_unit == 'nan':
        #     value = str(sensor_value)
        # else:
        #     value = str(sensor_value) + " " + data_unit

        payload_dict[sensor_name] = str(sensor_value)
        
        unit_name = sensor_name + '_unit'
        payload_dict[unit_name] = data_unit

    return payload_dict

