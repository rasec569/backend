const express = require("express");
const router = express.Router();
// invoca la conexion
const connection = require("../config/conexion");
// token para las peticiones a mysql
const jwt = require("jsonwebtoken");

// check tocken
router.use(function (req, res, next) {
  //Validate users access token on each request to our API.
  var token = req.headers.authorization.split(" ")[1];
  if (token) {
    jwt.verify(token, "MCG", function (err, decoded) {
      if (err) {
        return res.status(403).send({
          success: false,
          message: "Authorization required.",
        });
      } else {
        const content = jwt.verify(token, "MCG");
        req.data = content;
        next();
      }
    });
  } else {
    res.status(403).send({
      success: false,
      message: "No token provided.",
    });
    next();
  }
});
// sql call 
async function ListarEtapasProyecto(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarEtapasProyecto('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarEtapa(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarEtapa('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearEtapa(req){
  const {numero,estado,manzanas,idproyecto} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearEtapa('${numero}', '${estado}', '${manzanas}', '${idproyecto}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarEtapa(req){
  const { id} = req.params;
  const {numero,estado,manzanas} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarEtapa('${id}', '${numero}', '${estado}', '${manzanas}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarEtapa(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarEtapa('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar area
router.get("/proyecto/:id", async (req, res, next)=>{
  try {
    let result = await ListarEtapasProyecto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar area
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarEtapa(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear area
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearEtapa(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarEtapa(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarEtapa(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
  module.exports = router;