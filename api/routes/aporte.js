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
// listar aportes del acuerdo
router.get("/acuerdo/:id", (req, res) => {
    const { id } = req.params;
    conexion.query(`CALL ConsultarAportes('0','${id}')`, (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);       
      }
      else{
        console.log(" error en el backend",err);
      }
    });
  });
  // listar aportes del adicionales
  router.get("/contrato/:id", (req, res) => {
    const { id } = req.params;
    conexion.query(`CALL ConsultarAportes('${id}','0')`, (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);       
      }
      else{
        console.log(" error en el backend",err);
      }
    });
  });
  // Buscar
  router.get("/:id", (req, res) => {
  const { id } = req.params;
  conexion.query(`CALL ConsultarAporte('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//crear aporte acuerdo
router.post("/acuerdo/", (req, res) => {
  const {numero,concepto,referencia,destino,valor,fecha,cuotaid} = req.body;
  let sql = `CALL CrearAporteCuota('${numero}','${concepto}','${referencia}','${destino}','${valor}', '${fecha}', '${cuotaid}')`
  console.log(sql)
  conexion.query(sql,(err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);
      }
    }
  );
});
//crear aporte adicionales
  router.post("/contrato/", (req, res) => {
    const {numero,concepto,referencia,destino,valor,fecha,adicionalid} = req.body;
  let sql = `CALL CrearAporteAdicional('${numero}','${concepto}','${referencia}','${destino}','${valor}', '${fecha}','${adicionalid}')`
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
  let sql = `CALL EliminarAporte('${id}')`
  console.log(sql);
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
  const {numero,fecha,concepto,valor} = req.body;
  let sql = `CALL EditarAporte('${id}','${numero}', '${fecha}', '${concepto}', '${valor}')`;
  console.log(sql);
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      if (!err) {
        res.json(rows[0]);
      }
    }
  });
});

  module.exports = router;