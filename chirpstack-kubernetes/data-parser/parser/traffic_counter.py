from math import floor

def bin16dec(bin_):
    num = bin_ & 0xFFFF
    if 0x8000 & num:
        num = -(0x010000 - num)
    return num
#' Decoder Version 2.2 ' : app_payload_v2_decoder
def traffic_counter(payload_hex):
    bytes_ = bytearray.fromhex(payload_hex)
    decoded_payload = {}

    if len(bytes_) != 33:
        print('WARNING: Wrong payload length')

    # Check for Parametric TCR v2 payload
    elif bytes_[0] == 0xbe and bytes_[1] == 0x02 and bytes_[2] == 0x02:

        decoded_payload['SBX_BATT'] = (bytes_[3] << 8 | bytes_[4])
        decoded_payload['SBX_PV'] = (bytes_[5] << 8 | bytes_[6])
        temp = (bytes_[7] << 8) | (bytes_[8])
        decoded_payload['TEMP'] = floor(bin16dec(temp) / 10)

        # Speed class 1
        decoded_payload['Left0_CNT'] = (bytes_[9] << 8 | bytes_[10])
        decoded_payload['Left0_AVG'] = bytes_[11]
        decoded_payload['Right0_CNT'] = (bytes_[12] << 8 | bytes_[13])
        decoded_payload['Right0_AVG'] = bytes_[14]

        # Speed class 2
        decoded_payload['Left1_CNT'] = (bytes_[15] << 8 | bytes_[16])
        decoded_payload['Left1_AVG'] = bytes_[17]
        decoded_payload['Right1_CNT'] = (bytes_[18] << 8 | bytes_[19])
        decoded_payload['Right1_AVG'] = bytes_[20]

        # Speed class 3
        decoded_payload['Left2_CNT'] = (bytes_[21] << 8 | bytes_[22])
        decoded_payload['Left2_AVG'] = bytes_[23]
        decoded_payload['Right2_CNT'] = (bytes_[24] << 8 | bytes_[25])
        decoded_payload['Right2_AVG'] = bytes_[26]

        # Speed class 4
        decoded_payload['Left3_CNT'] = (bytes_[27] << 8 | bytes_[28])
        decoded_payload['Left3_AVG'] = bytes_[29]
        decoded_payload['Right3_CNT'] = (bytes_[30] << 8 | bytes_[31])
        decoded_payload['Right3_AVG'] = bytes_[32]

    else:
        print('WARNING: TCR application payload V2 should start with be0202..')

    return decoded_payload

# payload = 'be0202000000000128000000000000000110000000000000000000000000000000'