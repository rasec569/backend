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
async function ListarAcuerdosPagoCliente(req) {  
  const { id } = req.params; 
  return new Promise((resolve, reject) => {       
      let sql = `CALL ListarAcuerdosPagoCliente('${id}')`;
      console.log(sql);
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarAcuerdo(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarAcuerdoPago('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearAcuerdo(req){
  const {aporte_cliente,valor_credito,entidad,contratoid} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearAcuerdoPagoCliente('${aporte_cliente}', '${valor_credito}', '${entidad}', '${contratoid}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarAcuerdo(req){
  const {id} = req.params;
  const {aporte_cliente,valor_credito,entidad} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarAcuerdoPagoCliente('${id}', '${aporte_cliente}', '${valor_credito}', '${entidad}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarAcuerdo(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarAcuerdoPago('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// listar
router.get("/contrato/:id", async (req, res, next)=>{  
  try {
    let result = await ListarAcuerdosPagoCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
  });
  // Buscar 
  router.get("/:id", async (req, res, next)=>{
    try {
      let result = await BuscarAcuerdo(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
});
//crear
  router.post("/", async (req, res, next)=>{
    try {
      let result = await CrearAcuerdo(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
});
//eliminar
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarAcuerdo(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarAcuerdo(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});

  module.exports = router;