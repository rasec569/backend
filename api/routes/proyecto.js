const express = require("express");
const router = express.Router();
// invoca la conexion
const conexion = require("../config/conexion");
// token para las peticiones a mysql
const jwt = require("jsonwebtoken");

// Listar Proyectos
router.get('/', (req,res)=>{
  conexion.query('CALL `ConsultarProyectos`()', (err,rows,fields) => {
    if(!err){
      res.json(rows);
    }else{
      console.log(err);
    }
  })
});
// Buscar Proyecto
router.get("/:id", vericarToken, (req, res) => {
  const { id } = req.params;
  conexion.query(
    "SELECT Id_Proyecto, Nombre_Proyecto, Ubicacion_Proyecto FROM proyecto where Id_Proyecto=? ",
    [id],
    (err, rows, fields) => {
      if (!err) {
        res.json(rows);
      } else {
        console.log(err);
      }
    }
  );
});
//crear Proyecto
router.post("/", vericarToken, (req, res) => {
  const { Nombre_Proyecto, Ubicacion_Proyecto } = req.body;
  conexion.query(
    `INSERT INTO proyecto (Nombre_Proyecto, Ubicacion_Proyecto) VALUES ('${Nombre_Proyecto}','${Ubicacion_Proyecto}')`,
    (err, rows, fields) => {
      if (err) throw err;
      else {
        res.json({ status: "Proyecto Agregado" });
        console.log("Proyecto Agregado");
      }
    }
  );
});

//eliminar
router.delete("/:id", vericarToken, (req, res) => {
  const { id } = req.params;

  let sql = `delete from proyecto where Id_Proyecto = '${id}'`;
  conexion.query(sql, (err, rows, fields) => {
    if (err) throw err;
    else {
      res.json({ status: "Proyecto eliminado" });
    }
  });
});

//modificar
router.put("/:id", vericarToken, (req, res) => {
  const { id } = req.params;
  const { Nombre_Proyecto, Ubicacion_Proyecto } = req.body;
  let sql = `update proyecto set 
              Nombre_Proyecto ='${Nombre_Proyecto}',
              Ubicacion_Proyecto='${Ubicacion_Proyecto}'
              where Id_Proyecto = '${id}'`;
  conexion.query(sql, (err, rows, fields) => {
    if (err) throw err;
    else {
      res.json({ status: "Proyecto modificado" });
    }
  });
});
// funcion para vericar Token cada que hace una peticion a la Bd
function vericarToken(req, res, next) {
  if (!req.headers.authorization) return res.status(401).json("No autorizado");
  const token = req.headers.authorization.substr(7);
  if (token !== "") {
    const content = jwt.verify(token, "MCG");
    req.data = content;
    next();
  } else {
    res.status(401).json("Token vacio");
  }
}

module.exports = router;
