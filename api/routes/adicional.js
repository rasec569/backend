const express = require("express");
const router = express.Router();
// invoca la conexion
const conexion = require("../config/conexion");
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
// listar Adionales del Proyecto
router.get("/contrato/:id", (req, res) => {
    const { id } = req.params;
    conexion.query(`CALL ListarAdicionalesContrato('${id}')`, (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);       
      }
      else{
        console.log(" error en el backend",err);
      }
    });
  });
  // listar Adionales pendientes por pagar del Proyecto
  router.get("/pendientes/:id", (req, res) => {
    const { id } = req.params;
    conexion.query(`CALL ListarAdicionalesPendienteContrato('${id}')`, (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);       
      }
      else{
        console.log(" error en el backend",err);
      }
    });
  });
  // Buscar Adicional
  router.get("/:id", (req, res) => {
  const { id } = req.params;
  let sql = `CALL ConsultarAdicional('${id}')`
  console.log(sql);
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//crear
  router.post("/", (req, res) => {
  const {concepto,valor,fecha,contratoid} = req.body;
  let sql = `CALL CrearAdicional('${concepto}', '${valor}', '${fecha}', '${contratoid}')`
  console.log(sql)
  conexion.query(sql,(err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);
      }
    }
  );
});
//eliminar
router.delete("/", (req, res) => {  
  const {id} = req.body;
  let sql = `CALL EliminarAdicional('${id}')`
  console.log("llego",sql);
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }else{
      res.json(err);
    }
  });
});
//modificar
router.put("/:id", (req, res) => {
  const {id} = req.params;
  const {concepto,valor,fecha} = req.body;
  let sql = `CALL EditarAdicional('${id}', '${concepto}', '${valor}', '${fecha}')`;
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      if (!err) {
        res.json(rows[0]);
      }
    }
  });
});

  module.exports = router;