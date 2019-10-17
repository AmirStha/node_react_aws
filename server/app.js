const express = require("express");

const middlewares = require("./middlewares");
const routes = require("./routes");
const db = require("./utils/mongoClient");

const app = express();
db(app);
middlewares(app);
routes(app);

module.exports = app;
