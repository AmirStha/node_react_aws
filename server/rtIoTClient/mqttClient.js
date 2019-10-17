const awsIot = require('aws-iot-device-sdk')
const debug = require("debug")("rtIoTClient")

const config = require('../config')
const topicHandler = require('./topicHandler')

module.exports.init = (app) => {

  const rt_iot_client = awsIot.device({
    keyPath: `${__dirname}/${config.aws_mqtt.privateKey}`,
    certPath: `${__dirname}/${config.aws_mqtt.certFile}`,
    caPath: `${__dirname}/${config.aws_mqtt.rootCA}`,
    clientId: `${config.aws_mqtt.mqttClient}`,
    host: `${config.aws_mqtt.hostName}`
  });

  app.set("rt_iot_client", rt_iot_client)
  
  rt_iot_client
    .on('connect', function() {
      debug('connect');
      console.log('aws_mqtt connect');
      rt_iot_client.subscribe('data/mpu');
    });
  
  rt_iot_client
    .on('message', function(topic, payload) {
      debug('message', topic, payload.toString());
      topicHandler(topic , payload.toString())
    });

  return rt_iot_client
}
