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
async function ListarUsuarios() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarUsuarios()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarUsuario(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarUsuario('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearUsuario(req){
  const {nombres, apellidos, identificacion, telefono, direccion, correo, nick, password, IdRol, IdArea}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearUsuario('${nombres}', '${apellidos}', '${identificacion}', '${telefono}', '${direccion}', '${correo}', '${nick}', '${password}', '${IdRol}', '${IdArea}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarUsuario(req){
  const { id} = req.params;
  const {nombres, apellidos, identificacion, telefono, direccion, correo, nick, password, IdRol, IdArea}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarUsuario('${id}', '${nombres}', '${apellidos}', '${identificacion}', '${telefono}', '${direccion}', 
                                '${correo}', '${nick}', '${password}', '${IdRol}', '${IdArea}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarUsuario(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarUsuario('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar usuarios
router.get('/', async (req, res, next)=>{
  try {
    let result = await ListarUsuarios();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar usuario 
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarUsuario(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear usuario
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearUsuario(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarUsuario(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarUsuario(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
  
module.exports = router;