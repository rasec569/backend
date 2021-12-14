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
async function ListarAreas() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarAreas()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarArea(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarArea('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearArea(req){
  const {nombre, descripcion } = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearArea('${nombre}', '${descripcion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarArea(req){
  const { id} = req.params;
  const {nombre, descripcion, estado} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarArea('${id}', '${nombre}', '${descripcion}', '${estado}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarArea(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarArea('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar area
router.get('/', async (req, res, next)=>{
  try {
    let result = await ListarAreas();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar area
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarArea(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear area
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearArea(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarArea(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarArea(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
module.exports = router;