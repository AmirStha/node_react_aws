const _ = require("lodash");

const env = process.env.NODE_ENV || "dev";

let settings;

try {
  settings = require("./settings_" + env);
  console.log("Using environment ", env);
} catch (e) {
  console.log(
    ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n" +
      `>>>>>>cannot find ${env} setting using default<<<<<<<<\n` +
      ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
  );
  settings = require("./settings_dev");
  console.log("Using dev environment");
}
_.assign(settings, {});

settings.env = env;

_.assign(settings, {
  env
});

module.exports = settings;
