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
async function ListarEgresos() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarEgresos()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarEgresosObligacion(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarEgresosObligacion('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarEgreso(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarEgreso('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearEgreso(req){
  const {numero, fecha, referencia, valor, obligacionid,}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearEgreso('${numero}', '${fecha}', '${referencia}', '${valor}', '${obligacionid}')`;
    console.log(sql);
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarEgreso(req){
  const { id} = req.params;
  const {numero, fecha, referencia, valor}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarEgreso('${id}', '${numero}', '${fecha}', '${referencia}', '${valor}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarEgreso(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarEgreso('${id}')`;
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
    let result = await ListarEgresos();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
/// listar egresos de obligacion
router.get("/obligacion/:id", async (req, res, next)=>{
  try {
    let result = await ListarEgresosObligacion(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar 
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarEgreso(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear 
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearEgreso(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarEgreso(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarEgreso(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});  
module.exports = router;