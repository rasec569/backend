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
// Listar obligaciones
router.get('/', (req,res)=>{
  try{
    conexion.query('CALL `ListarObligaciones`()', (err,rows,fields) => {
      if(!err){
        res.json(rows[0]);
      }else{
        console.log(err);
      }
    })
  }catch(err) {
    throw new Error(err)
  }
  
});
    
  // Buscar 
router.get("/:id", (req, res) => {
    const {id} = req.params;
    conexion.query(`CALL ConsultarObligacion('${id}')`, (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);
      }
    });
  });
  //crear
router.post("/", (req, res) => {
  const {fecha, concepto, valor, interes, total, fecha_pago, idacreedor}= req.body;
  let sql = `CALL CrearObligacion('${fecha}', '${concepto}', '${valor}', '${interes}', '${total}', '${fecha_pago}', '${idacreedor}')`;
  conexion.query(sql,
    (err, rows, fields) => {
      console.log(sql);
      if (!err) {
        res.json(rows[0]);
      }else{
        res.json(err);
        console.log(err)
      }
    }
  );
});
//modificar
router.put("/:id", (req, res) => {  
  const { id} = req.params;
  const {fecha, concepto, valor, interes, total, fecha_pago}= req.body;
  let sql = `CALL EditarObligacion('${id}', '${fecha}', '${concepto}', '${valor}', '${interes}', '${total}', '${fecha_pago}')`;
  console.log(sql);
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      if (!err) {
        res.json(rows[0]);
      }
    }
  });
});
//eliminar 
router.delete("/", (req, res) => {
  const { id } = req.body;
  conexion.query(`CALL EliminarObligacion('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }else{
      res.json(err);
    }
  });
});
  module.exports = router;