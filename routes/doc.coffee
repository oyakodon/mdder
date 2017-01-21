express = require 'express'
router = express.Router()

# GET Start Document
router.get '/', (req, res, next) ->
  fs = require 'fs'
  md = fs.readFileSync 'doc/start.md', 'utf-8'
  res.send(md);

module.exports = router
