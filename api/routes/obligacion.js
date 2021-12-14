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
async function ListarObligaciones() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarObligaciones()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarObligacion(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarObligacion('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearObligacion(req){
  const {fecha, concepto, valor, interes, total, fecha_pago, idacreedor}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearObligacion('${fecha}', '${concepto}', '${valor}', '${interes}', '${total}', '${fecha_pago}', '${idacreedor}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarObligacion(req){
  const { id} = req.params;
  const {fecha, concepto, valor, interes, total, fecha_pago}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarObligacion('${id}', '${fecha}', '${concepto}', '${valor}', '${interes}', '${total}', '${fecha_pago}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarObligacion(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarObligacion('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar 
router.get('/', async (req, res, next)=>{
  try {
    let result = await ListarObligaciones(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarObligacion(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearObligacion(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EditarObligacion(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EliminarObligacion(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});  
  module.exports = router;