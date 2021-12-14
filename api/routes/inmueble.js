const express= require('express');
const router= express.Router();
// invoca la conexion
const connection = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

// enviar mas de un parametro (/:id/:nombre)
//se obtiene con el req.params.id, req.params.nombre
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
async function ListarInmuebles() {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarInmuebles()`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarInmueblesProyecto(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarInmueblesProyecto('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListaInmueblesVenta(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListaInmueblesVenta('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarInmueblesEtapa(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarInmueblesEtapa('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarInmueble(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarInmueble('${id}')`;
      console.log(sql)
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}

async function CrearInmueble(req){
  const {manzana, casa, Valor_Inicial, Valor_Final, catastral, escritura, matricula, estado, idproyecto, idetapa}= req.body; 
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearInmueble('${manzana}', '${casa}', '${Valor_Inicial}', '${Valor_Final}', '${catastral}', '${escritura}', '${matricula}', '${estado}', '${idproyecto}','${idetapa}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarInmueble(req){
  const { id} = req.params;
  const {manzana, casa, Valor_Inicial, Valor_Final, catastral, escritura, matricula, estado, idproyecto, idetapa}= req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarInmueble('${id}', '${manzana}', '${casa}', '${Valor_Inicial}','${Valor_Final}', '${catastral}', '${escritura}', '${matricula}', '${estado}', '${idproyecto}','${idetapa}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarInmueble(req) {
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
    let result = await ListarInmuebles();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarInmueble(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get('/proyecto/:id', async (req, res, next)=>{
  try {
    let result = await ListarInmueblesProyecto(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get('/etapa/:id', async (req, res, next)=>{
  try {
    let result = await ListarInmueblesEtapa(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get('/venta/:id', async (req, res, next)=>{
  try {
    let result = await ListaInmueblesVenta(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearInmueble(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarInmueble(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarInmueble(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
module.exports = router;