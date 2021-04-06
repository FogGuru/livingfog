This is an application for parsing data collected from sensors in La Marina Valencia

It subscribes to the MQTT where the chirpstack application server publishes to, then 
parses the sensor data accroding to the types of sensor, and publishes the parsed data 
to the MQTT and Influxdb.

The topic for each device is: "SensorType/SensorLocation"

Sensor type is recorded in `conf/devEUI.json` and the location is in `conf/location.json`

##### To run data-parser locally

`python main.py $MQTT_SERVER`


##### To add new devices when the parser is really

1) add the devEUI to conf/devEUI.json
2) add the location in the map to conf/location.json


##### To add new parser
1) add your parser file to folder parser/
2) edit configuration files in conf/devEUI.json and conf/location.json
3) update main.py to include the new parser


##### Docker image
Once all the files are configured, then you can build your own image and push to your docker registry

1) docker build -t data-parser .

2) docker tag "YOUR IMAGE"

3) docker push  "YOUR REPOSITORY"

To run docker container with:

`docker run -it --rm   -e "MQTT_SERVER=192.168.0.175" --name test_parser data-parser`




