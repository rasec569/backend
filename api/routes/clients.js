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


// Listar clientes
router.get("/", (req, res) => {
  conexion.query("CALL `ConsultarClientes`()", (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});

router.get("/:id", (req, res) => {
  const {
    id
  } = req.params;
  conexion.query(`CALL ConsultarCliente('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});

//Cliente
router.post("/", (req, res) => {
  const {
    identification,
    nombres,
    apellidos,
    telefono,
    direccion,
    correo
  } =
  req.body;
  conexion.query(
    `CALL CrearCliente('${nombres}', '${apellidos}', '${identification}', '${telefono}', '${direccion}', '${correo}')`,
    (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);
      }
    }
  );
});

//eliminar
router.delete("/", (req, res) => {
  const {
    id
  } = req.body;
  conexion.query(`CALL EliminarCliente('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }else{
      res.json(err);
    }
  });
});

//modificar
router.put("/:id", (req, res) => {
  const {
    id
  } = req.params;
  const {
    nombres,
    apellidos,
    telefono,
    direccion,
    correo
  } = req.body;
  let sql = `CALL EditarCliente('${id}', '${nombres}', '${apellidos}', '${correo}', '${telefono}', '${direccion}')`;
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      if (!err) {
        res.json(rows[0]);
      }
    }
  });
});
module.exports = router;