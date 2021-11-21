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
// listar Etapas del Proyecto
router.get("/proyecto/:id", (req, res) => {
    const { id } = req.params;
    conexion.query(`CALL ListarEtapasProyecto('${id}')`, (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);       
      }
      else{
        console.log(" error en el backend",err);
      }
    });
  });
  // Buscar etapa
  router.get("/:id", (req, res) => {
  const { id } = req.params;
  let sql = `CALL ConsultarEtapa('${id}')`
  console.log(sql)
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//crear Proyecto
  router.post("/", (req, res) => {
  const {numero,estado,manzanas,idproyecto} = req.body;
  let sql = `CALL CrearEtapa('${numero}', '${estado}', '${manzanas}', '${idproyecto}')`
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
  conexion.query(`CALL EliminarEtapa('${id}')`, (err, rows, fields) => {
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
  const {numero,estado,manzanas} = req.body;
  let sql = `CALL EditarEtapa('${id}', '${numero}', '${estado}', '${manzanas}')`;
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