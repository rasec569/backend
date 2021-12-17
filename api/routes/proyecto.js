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
async function ListarProyectos() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarProyectos()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarProyecto(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarProyecto('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarDetalleProyecto(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarProyectoDetalle('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function CrearProyecto(req){
  const {nombre, ubicacion, estado,num_etapa,estado_etapa,manzanas} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearProyecto('${nombre}', '${ubicacion}','${estado}','${num_etapa}', '${estado_etapa}', '${manzanas}')`;
    console.log(sql)
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarProyecto(req){
  const { id} = req.params;
  const {nombre, ubicacion, estado} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarProyecto('${id}', '${nombre}', '${ubicacion}', '${estado}')`;
    console.log(sql);
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarProyecto(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarProyecto('${id}')`;
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
    let result = await ListarProyectos();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarProyecto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar detalle Proyecto
router.get("/detalle/:id", async (req, res, next)=>{
  try {
    let result = await BuscarDetalleProyecto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearProyecto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarProyecto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarProyecto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
module.exports = router;
