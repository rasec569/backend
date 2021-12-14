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
async function ListarAdicionalesContrato(req) {
  const { id } = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarAdicionalesContrato('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarAdicionalesPendientePago(req) {
  const { id } = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarAdicionalesPendienteContrato('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarAdicional(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarAdicional('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearAdicional(req){
  const {concepto,descripcion,valor,fecha,contratoid} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearAdicional('${concepto}','${descripcion}', '${valor}', '${fecha}', '${contratoid}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarAdicional(req){
  const {id} = req.params;
  const {concepto,descripcion,valor,fecha} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarAdicional('${id}', '${concepto}','${descripcion}', '${valor}', '${fecha}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarAdicional(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarAdicional('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// listar Adionales del Proyecto
router.get("/contrato/:id", async (req, res, next)=>{
  try {
    let result = await ListarAdicionalesContrato(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
  });
  // listar Adionales pendientes por pagar del Proyecto
  router.get("/pendientes/:id", async (req, res, next)=>{
    try {
      let result = await ListarAdicionalesPendientePago(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
  });
  // Buscar Adicional
  router.get("/:id", async (req, res, next)=>{
    try {
      let result = await BuscarAdicional(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
});
//crear
  router.post("/", async (req, res, next)=>{
    try {
      let result = await CrearAdicional(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
});
//eliminar
router.delete("/", async (req, res, next)=>{  
  try {
    let result = await EliminarAdicional(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarAdicional(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
  module.exports = router;