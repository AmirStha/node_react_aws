const debug = require("debug")("rtIoTClient");

// const { saveData } = require("./../models/dataServices")

const topics = require("./topics");

module.exports = (topic, message) => {
  console.log(topic);
  let data = null;
  try {
    data = JSON.parse(message);
    // console.log( data )
  } catch (e) {
    console.log("error parsing json: ", e);
  }

  switch (topic) {
    case `data/${topics.data}`:
      console.log("data: ", data);
      // saveData({device_id: data.deviceId, serial_number: data.serialNumber, payload: data.payload})
      break;
    default:
      debug("No handler for topic %s", topic);
  }
};
