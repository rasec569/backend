const express= require('express');
const router= express.Router();
// invoca la conexion
const conexion = require('../config/conexion');
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
// Listar usuarios
router.get('/', (req,res)=>{
  conexion.query('CALL `ConsultarUsuarios`()', (err,rows,fields) => {
    if(!err){
      res.json(rows[0]);
    }else{
      console.log(err);
    }
  })
});
// Buscar usuario con el parametro id que se le pasa en la direccion
router.get("/:id", (req, res) => {
  const {id} = req.params;
  conexion.query(`CALL ConsultarUsuario('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//crear usuario
router.post("/", (req, res) => {
  const {nombres, apellidos, identificacion, telefono, direccion, correo, nick, password, IdRol, IdArea}= req.body;
  conexion.query(`CALL CrearUsuario('${nombres}', '${apellidos}', '${identificacion}', '${telefono}', '${direccion}', '${correo}', '${nick}', '${password}', '${IdRol}', '${IdArea}')`,
    (err, rows, fields) => {
      /* console.log(rows) */
      if (!err) {
        res.json(rows[0]);
      }else{
        res.json(err);
        console.log(err)
      }
    }
  );
});
//eliminar 
router.delete("/", (req, res) => {
  const { id } = req.body;
  conexion.query(`CALL EliminarUsuario('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }else{
      res.json(err);
    }
  });
});
//modificar
router.put("/:id", (req, res) => {
  const { id} = req.params;
  const {nombres, apellidos, identificacion, telefono, direccion, correo, nick, password, IdRol, IdArea}= req.body;
  let sql = `CALL EditarUsuario('${id}', '${nombres}', '${apellidos}', '${identificacion}', '${telefono}', '${direccion}', 
                                '${correo}', '${nick}', '${password}', '${IdRol}', '${IdArea}')`;
  /* console.log(sql) */
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      if (!err) {
        res.json(rows[0]);
      }
    }
  });
});
  
module.exports = router;