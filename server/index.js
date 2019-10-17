const config = require("./config");
const http = require("http");
const app = require("./app.js");
// const agenda =  require('./agenda')
const rtIoTClient = require("./rtIoTClient/mqttClient");
const serverConfig = config.server;

const server = {
  start: function start() {
    const httpServer = http.createServer(app);

    // rtIoTClient.init(app);

    app.set("port", serverConfig.port);
    httpServer.listen(serverConfig.port, serverConfig.ip);
    console.info(`Server running at https://localhost:${serverConfig.port}`);
  }
};

server.start();
