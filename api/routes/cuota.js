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
async function ListarCuotasVencidas(req) {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarCuotasVencidas()`;
      console.log(sql)
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarCuotasPorPagar(req) {
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarCuotasPorPagar()`;
      console.log(sql)
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarCuotasAcuerdoPagoCliente(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarCuotasAcuerdoPagoCliente('${id}')`;
      console.log(sql)
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarCuotaAcuerdoPagoBanco(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarCuotaAcuerdoPagoBanco('${id}')`;
      console.log(sql)
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function ListarCuotasPendientesAcuerdoPago(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ListarCuotasPendientesAcuerdo('${id}')`;
      console.log(sql);
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
async function BuscarCuota(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL ConsultarCuota('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}

async function CrearCuotaAcuerdoPago(req){
  const {numero,valor,fecha,responsable,acuerdoid} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL CrearCuotaAcuerdoPago('${numero}', '${valor}', '${fecha}','${responsable}', '${acuerdoid}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EditarCuotaAcuerdo(req){
  const { id} = req.params;
  const {numero,valor,fecha} = req.body;
  return new Promise((resolve, reject) => {
    let sql = `CALL EditarCuotaAcuerdo('${id}', '${numero}', '${valor}', '${fecha}')`;
    connection.query(sql, function (err, result) {
        if (err) reject(err);
        resolve(result);
    });
});
}
async function EliminarCuota(req) {
  const {id} = req.params;
  return new Promise((resolve, reject) => {
      let sql = `CALL EliminarCuota('${id}')`;
      connection.query(sql, function (err, result) {
          if (err) reject(err);
          resolve(result);
      });
  });
}
//Routes
// Listar 
router.get('/vencidas/', async (req, res, next)=>{
  try {
    let result = await ListarCuotasVencidas();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get('/pagar/', async (req, res, next)=>{
  try {
    let result = await ListarCuotasPorPagar();
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get("/cliente/:id", async (req, res, next)=>{
  try {
    let result = await ListarCuotasAcuerdoPagoCliente(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get('/credito/:id', async (req, res, next)=>{
  try {
    let result = await ListarCuotaAcuerdoPagoBanco(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
router.get('/pendiente/:id', async (req, res, next)=>{
  try {
    let result = await ListarCuotasPendientesAcuerdoPago(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
// Buscar
router.get("/:id", async (req, res, next)=>{
  try {
    let result = await BuscarCuota(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//crear
router.post("/", async (req, res, next)=>{
  try {
    let result = await CrearCuotaAcuerdoPago(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//eliminar 
router.delete("/", async (req, res, next)=>{
  try {
    let result = await EliminarCuota(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
//modificar
router.put("/:id", async (req, res, next)=>{
  try {
    let result = await EditarCuotaAcuerdo(req);
    res.json(result[0]);
  } catch (error) {
    res.json(error);
  }
});
  module.exports = router;