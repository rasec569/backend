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
async function ListarClientes() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarClientes()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarCliente(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarCliente('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearCliente(req){
  const {identificacion, nombres, apellidos, telefono, direccion, correo} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearCliente('${nombres}', '${apellidos}', '${identificacion}', '${telefono}', '${direccion}', '${correo}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarCliente(req){
  const { id} = req.params;
  const {nombres, apellidos, telefono, direccion, correo} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarCliente('${id}', '${nombres}', '${apellidos}', '${correo}', '${telefono}', '${direccion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarCliente(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarCliente('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar clientes

router.get("/", async (req, res, next)=>{
  try {
    let result = await ListarClientes();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});

router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});

//Cliente
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});

//eliminar
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});

//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
module.exports = router;