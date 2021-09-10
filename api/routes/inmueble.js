const express= require('express');
const router= express.Router();
// invoca la conexion
const conexion = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

// enviar mas de un parametro (/:id/:nombre)
//se obtiene con el req.params.id, req.params.nombre
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
//listar todos
router.get('/', (req,res)=>{
  conexion.query('CALL `ConsultarInmuebles`()', (err,rows,fields) => {
    if(!err){
      res.json(rows[0]);
    }else{
      console.log(err);
    }
  })
});
//listar por proyecto ConsultarInmueblesProyecto
router.get('/proyecto/:id', (req,res)=>{
  const {id} = req.params;
  conexion.query(`CALL ConsultarInmueblesProyecto('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//Buscar inmueble
router.get('/:id', (req,res)=>{
  const {id} = req.params;
  conexion.query(`CALL ConsultarInmueble('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});
//crear
router.post("/", (req, res) => {
  const {manzana, casa, Valor_Inicial, Valor_Final, catastral, escritura, matricula, estado, idproyecto}= req.body;    
  conexion.query(
    `CALL CrearInmueble('${manzana}', '${casa}', '${Valor_Inicial}', '${Valor_Final}', '${catastral}', '${escritura}', '${matricula}', '${estado}', '${idproyecto}')`,
    (err, rows, fields) => {      
      if (!err) {
        res.json(rows[0]);
      }
    }    
  );
});
//eliminar 
router.delete("/", (req, res) => {
  const { id } = req.body;
  conexion.query(`CALL EliminarInmueble('${id}')`, (err, rows, fields) => {
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
  const {manzana, casa, Valor_Inicial, Valor_Final, catastral, escritura, matricula, estado, idproyecto}= req.body;
  let sql = `CALL EditarInmueble('${id}', '${manzana}', '${casa}', '${Valor_Inicial}','${Valor_Final}', '${catastral}', '${escritura}', '${matricula}', '${estado}', '${idproyecto}')`;
  conexion.query(sql, (err, rows, fields) => {
    if (!err) {
      if (!err) {
        res.json(rows[0]);
      }
    }
  });
});
module.exports = router;