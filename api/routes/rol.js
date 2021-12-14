const express= require('express');
const router= express.Router();
// invoca la conexion
const connection = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

// check tocken
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
// sql call 
async function ListarRoles() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarRoles()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ConsultarRol(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarRol('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearRol(req){
  const {nombre, descripcion} =  req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearRol('${nombre}', '${descripcion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarRol(req){
  const { id} = req.params;
  const {nombre, descripcion} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarRol('${id}', '${nombre}','${descripcion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarRol(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarRol('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar roles
router.get('/', async (req, res, next)=>{
  try {
    let result = await ListarRoles();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});

router.get("/:id", async (req, res, next)=>{
  try {
    let result = await ConsultarRol(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear rol
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearRol(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/",async (req, res, next)=>{
  try {
    let result = await EditarRol(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EliminarRol(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
module.exports = router;