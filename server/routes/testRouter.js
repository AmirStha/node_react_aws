const express = require("express")
const router = express.Router()

const resUtil = require("../utils/responseUtil")

router.get("/test", (req, res) => {
  console.log("this is a test route")
  res.json({"test": "test"})
})

module.exports = router