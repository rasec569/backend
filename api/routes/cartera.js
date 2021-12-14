const express= require('express');
const router= express.Router();
// invoca la conexion
const connection = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');
// check tocken
// var getSqlConnection = conexion.getSqlConnection;
// var Promise = require("bluebird");

router.use(function (req, res, next) {
  //Validate users access token on each request to our API.
  var token = req.headers.authorization.split(" ")[1];
  if (token) {
    jwt.verify(token, 'MCG', function (err, decoded) {
      if (err) {
        return res.status(403).send({
          success: false,
          message: 'Authorization required.'
        });
      } else {
        const content = jwt.verify(token, 'MCG');
        req.data = content;
        next();
      }
    });
  } else {
    res.status(403).send({
      success: false,
      message: 'No token provided.'
    });
    next();
  }
});
async function listarCartera() {
  return new Promise((resolve, reject) => {
      let sql = 'CALL `ListarCartera`()';
      connection.query(sql, function (err, result) {
        console.log("entra");
          if (err) reject(err);
          resolve(result);
      });
  });
}
router.get('/', async (req, res, next)=>{
  try {
    let result = await listarCartera();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});

module.exports = router;