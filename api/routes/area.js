const express= require('express');
const router= express.Router();
// invoca la conexion
const conexion = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

// Listar area
router.get('/', (req,res)=>{
    conexion.query('SELECT * FROM area', (err,rows,fields) => {
      if(!err){
        res.json(rows);
        console.log(res);
      }else{
        console.log(err);
      }
    })
});

module.exports = router;