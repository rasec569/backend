const express = require("express");
const router = express.Router();
// invoca la conexion
const connection = require("../config/conexion");
// token para las peticiones a mysql
// const jwt = require("jsonwebtoken");

// check tocken
/* router.use(function (req, res, next) {
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
}); */
// sql call 
async function ListarContratos() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarContratos()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarContratosClientes(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarContratosClientes('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarContrato(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarContrato('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearContratoCliente(req){
  /* console.log("",req) */
  const {clienteid, numero,forma_pago,valor,fecha, observacion, inmuebleid} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearContratoCliente('${clienteid}', '${numero}', '${forma_pago}', '${valor}', '${fecha}', '${observacion}', '${inmuebleid}')`;
    console.log(sql);
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarContratoCliente(req){
  const { id} = req.params;
  const {numero,forma_pago,valor, valor_total,fecha, observacion, inmuebleid} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarContratoCliente('${id}', '${numero}', '${forma_pago}','${valor}','${valor_total}','${fecha}','${observacion}','${inmuebleid}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarContratoCliente(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarContratoCliente('${id}')`;
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
    let result = await ListarContratos();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarContrato(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// listar contratos del cliente
router.get("/cliente/:id", async (req, res, next)=>{
  try {
    let result = await ListarContratosClientes(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearContratoCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EditarContratoCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EliminarContratoCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
module.exports = router;
