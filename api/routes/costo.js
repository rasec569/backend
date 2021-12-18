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
async function listarCostos() {
  return new Promise((resolve, reject) => {
      let sql = 'CALL `ListarCostos`()';
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarCostosInmueble(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarCostosInmueble('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ConsultarCosto(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarCosto('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearCostoInmueble(req){
  const {concepto, valor, idinmueble ,fecha } = req.body;
  return new Promise((resolve, reject) => {
    let sql =`CALL CrearCostoInmueble('${concepto}', '${valor}', '${idinmueble}', '${fecha}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function AsociarCostoInmueble(req){
  const {id, idinmueble ,fecha } = req.body;
  return new Promise((resolve, reject) => {
    let sql =`CALL AsociarCostoInmuble('${id}','${idinmueble}', '${fecha}')`;
    console.log(sql);
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarCostoInmueble(req){
  const { id} = req.params;
  const {concepto, valor, idinmueble ,fecha } = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarCostoInmueble('${id}', '${concepto}', '${valor}', '${fecha}', '${idinmueble}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarCosto(req) {
  const { id } = req.body;
    const {idinmueble } = req.body;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarCostoInmueble('${id}', '${idinmueble}')`;
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
    let result = await listarCostos();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get('/inmueble/:id', async (req, res, next)=>{
  try {
    let result = await ListarCostosInmueble(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await ConsultarCosto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearCostoInmueble(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear
router.post("/asociar/", async (req, res, next)=>{
  try {
    let result = await AsociarCostoInmueble(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarCosto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarCostoInmueble (req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});  
  module.exports = router;