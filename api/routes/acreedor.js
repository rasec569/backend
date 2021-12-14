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
async function listarAcreedores() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarAcreedores()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarAcreedor(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarAcreedor('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearAcreedor(req){
  const {nombres, apellidos, identificacion, telefono, direccion, correo, descripcion}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearAcreedor('${nombres}', '${apellidos}', '${identificacion}', '${telefono}', '${direccion}', '${correo}', '${descripcion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarAcreedor(req){
  const { id} = req.params;
  const {nombres, apellidos, identificacion, telefono, direccion, correo, descripcion}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarAcreedor('${id}', '${nombres}', '${apellidos}', '${identificacion}', '${telefono}', '${direccion}', '${correo}', '${descripcion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarAcreedor(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarAcreedor('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar acreedor
router.get('/', async (req, res, next)=>{
  try {
    let result = await listarAcreedores();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar acreedor
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarAcreedor(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear acreedor
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearAcreedor(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{  
  try {
    let result = await EditarAcreedor(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarAcreedor(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});  
module.exports = router;