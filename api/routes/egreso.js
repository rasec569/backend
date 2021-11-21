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
// Listar egresos
router.get('/', (req,res)=>{
  conexion.query('CALL `ListarEgresos`()', (err,rows,fields) => {
    if(!err){
      res.json(rows[0]);
    }else{
      console.log(err);
    }
  })
});
// listar egresos de obligacion
router.get("/obligacion/:id", (req, res) => {
    const { id } = req.params;
    let sql=`CALL ListarEgresosObligacion('${id}')`;
    console.log(sql)
    conexion.query(sql, (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);       
      }
      else{
        console.log(" error en el backend",err);
      }
    });
  });
// Buscar egreso con el parametro id que se le pasa en la direccion
router.get("/:id", (req, res) => {
  const {id} = req.params;
  conexion.query(`CALL ConsultarEgreso('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//crear egreso
router.post("/", (req, res) => {
  const {numero, fecha, referencia, valor, obligacionid,}= req.body;
  let sql = `CALL CrearEgreso('${numero}', '${fecha}', '${referencia}', '${valor}', '${obligacionid}')`
  console.log(sql)
  conexion.query(sql, (err, rows, fields) => {
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
  conexion.query(`CALL EliminarEgreso('${id}')`, (err, rows, fields) => {
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
  const {numero, fecha, referencia, valor}= req.body;
  let sql = `CALL EditarEgreso('${id}', '${numero}', '${fecha}', '${referencia}', '${valor}')`;
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