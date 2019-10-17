const path = require("path");

const rootPath = path.normalize(`${__dirname}/../..`);
const publicPath = `${rootPath}/build`;

module.exports = {
  device_id: process.env.DEVICE_ID || "default",
  mdb: "mongodb://Amirpj:Amir123@ds161794.mlab.com:61794/rt-v1",
  jwt: { secret: "dasdasadsasdas", expiresIn: "15d" },
  aws_mqtt: {
    mqttPort: "1883",
    mqttKeepAlive: "60",
    mqttClient: "rt_iot_service_mqtt_client",
    hostName: "aot2wgmcbqwsa-ats.iot.ap-south-1.amazonaws.com",
    rootCA: "certs/root.ca.bundle.pem",
    privateKey: "certs/29013ee65.RT_THING1-private.pem.key",
    certFile: "certs/29013ee65.RT_THING1-certificate.pem.crt"
  },
  server: {
    port: process.env.PORT || 3001,
    ip: "0.0.0.0",
    rootPath,
    publicPath
  }
};
