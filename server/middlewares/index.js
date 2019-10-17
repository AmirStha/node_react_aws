const express = require("express");
const compression = require("compression");
const bodyParser = require("body-parser");
const cors = require("cors");

const config = require("./../config");

module.exports = app => {
  console.log(">>>>>>>> config.server.publicPath: ", config.server.publicPath);
  // remove x-powered-by
  app.disable("x-powered-by");

  // Add express stuff
  app.use(compression());
  app.use(bodyParser.urlencoded({ extended: true }));
  app.use(bodyParser.json({ limit: "20mb" }));
  app.use("/", express.static(config.server.publicPath));
};
