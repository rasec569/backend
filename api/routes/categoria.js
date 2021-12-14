const express = require('express');
const router = express.Router();
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
async function ListarCategorias() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarCategorias()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarCategoria(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarCategoria('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearCategoria(req){
  const {nombre, descripcion } = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearCategoria('${nombre}', '${descripcion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarCategoria(req){
  const { id} = req.params;
  const {nombre, descripcion} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarCategoria('${id}', '${nombre}', '${descripcion}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarCategoria(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarCategoria('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar categoria
router.get('/', async (req, res, next)=>{
  try {
    let result = await ListarCategorias();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar categoria
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarCategoria(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear categoria
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearCategoria(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
  });
  //eliminar
router.delete("/", async (req, res, next)=>{  
  try {
    let result = await EliminarCategoria(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
  });
  //modificar
  router.put("/:id", async (req, res, next)=>{
    try {
      let result = await EditarCategoria(req);
      res.json(result[0]);
    } catch (error) {
      res.json(error);
    }
  });
module.exports = router;