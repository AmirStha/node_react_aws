const path = require("path");
const config = require("./../config");
// const auth = require('./auth');
const test = require("./../routes/testRouter");

// const production = process.env.NODE_ENV === 'production';

module.exports = app => {
  // app.get("/",(req,res,next)=>{res.json({server:true})})
  // app.use('/auth', auth);

  app.use("/test", test);

  app.use("/*", (req, res, next) => {
    res.sendFile(path.join(__dirname, "../dist/index.html"));
  });

  app.use(function(err, req, res, next) {
    if (!err.statusCode) err.statusCode = 500; // If err has no specified error code, set error code to 'Internal Server Error (500)'
    if (app.get("env") === "development") {
      if (err.isJoi === true) delete err._object;
      res.status(err.statusCode).send(err); // All HTTP requests must have a response, so let's send back an error with its status code and message
    } else {
      res.status(err.statusCode).send(err.message);
    }
  });

  // if (production) {
  //   app.get('/*', (request, response) => {
  //     response.sendFile(`${appConfig.publicPath}/index.html`);
  //   });
  // }
  // else {
  //   app.get('/*', (request, response) => {
  //     response.sendFile(`${appConfig.devPath}/index.html`);
  //   });
  // }
};
