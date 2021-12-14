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
async function ListarAportesAcuerdo(req) {
  const { id } = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarAportes('0','${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarAportesAdicionales(req) {
  const { id } = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarAportes('${id}','0')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ConsultarAportesDetalle(req) {
  const { cuota } = req.params;
  const { adicional } = req.params;
  return new Promise((resolve, reject) => {
    let sql = `CALL ConsultarAportesDetalle('${cuota}','${adicional}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ConsultarNumeroMaxAporte(req) {
  const { cuota } = req.params;
  const { adicional } = req.params;
  return new Promise((resolve, reject) => {
    let sql = `CALL ConsultarNumeroMaxAporte('${cuota}','${adicional}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarAporte(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarAporte('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearAporteCuota(req){
  const {numero,concepto,referencia,destino,valor,fecha,cuotaid} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearAporteCuota('${numero}','${concepto}','${referencia}','${destino}','${valor}', '${fecha}', '${cuotaid}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function CrearAporteAdicional(req){
  const {numero,concepto,referencia,destino,valor,fecha,adicionalid} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearAporteAdicional('${numero}','${concepto}','${referencia}','${destino}','${valor}', '${fecha}','${adicionalid}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarAdicional(req){
  const {id} = req.params;
  const {numero,fecha,concepto,valor} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarAporte('${id}','${numero}', '${fecha}', '${concepto}', '${valor}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarAporte(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarAporte('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// listar aportes del acuerdo
router.get("/acuerdo/:id", async (req, res, next)=>{
  try {
    let result = await ListarAportesAcuerdo(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
  });
  // listar aportes del adicionales
  router.get("/contrato/:id", async (req, res, next)=>{
    try {
      let result = await ListarAportesAdicionales(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
  });
  // listar detalle aportes
  router.get("/detalle/:cuota/:adicional", async (req, res, next)=>{
    try {
      let result = await ConsultarAportesDetalle(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
  });
  // Buscar
  router.get("/:id", async (req, res, next)=>{
    try {
      let result = await BuscarAporte(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
});
// Buscar ultimo num aporte
router.get("/max/:cuota/:adicional", async (req, res, next)=>{
  try {
    let result = await ConsultarNumeroMaxAporte(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear aporte acuerdo
router.post("/acuerdo/", async (req, res, next)=>{
  try {
    let result = await CrearAporteCuota(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear aporte adicionales
  router.post("/contrato/", async (req, res, next)=>{
    try {
      let result = await CrearAporteAdicional(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
});
//eliminar
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarAporte(req);
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