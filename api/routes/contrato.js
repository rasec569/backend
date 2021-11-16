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
// listar contratos
router.get("/", (req, res) => {
  conexion.query(
    `CALL ConsultarContratos()`,
    (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);
      } else {
        console.log(" error en el backend", err);
      }
    }
  );
});
// listar contratos del inmueble
router.get("/cliente/:id", (req, res) => {
  const { id } = req.params;
  conexion.query(
    `CALL ConsultarContratosClientes('${id}')`,
    (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);
      } else {
        console.log(" error en el backend", err);
      }
    }
  );
});
// Buscar contrato
router.get("/:id", (req, res) => {
  const { id } = req.params;
  let sql = `CALL ConsultarContrato('${id}')`
  console.log(sql)
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//crear contrato
router.post("/", (req, res) => {
    const {idcliente, Numero_Contrato,Forma_Pago,valor,fecha, observacion, idinmueble} = req.body;
    let sql = `CALL CrearContratoCliente('${idcliente}', '${Numero_Contrato}', '${Forma_Pago}', '${valor}', '${fecha}', '${observacion}', '${idinmueble}')`
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
  conexion.query(`CALL EliminarContrato('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }else{
      res.json(err);
    }
  });
});
//modificar ojo por terminar
router.put("/:id", (req, res) => {
  const {id} = req.params;
  const {numero,estado,manzanas} = req.body;
  let sql = `CALL EditarContrato('${id}', '${numero}', '${estado}', '${manzanas}')`;
  console.log(sql)
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      if (!err) {
        res.json(rows[0]);
      }
    }
  });
});
module.exports = router;
