const express= require('express');
const router= express.Router();
// invoca la conexion
const conexion = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

// Listar roles
router.get('/', (req,res)=>{
  conexion.query('CALL `ConsultarRoles`()', (err,rows,fields) => {
    if(!err){
      res.json(rows);
    }else{
      console.log(err);
    }
  })
});

/* router.get('/', (req,res)=>{
    conexion.query('SELECT * FROM rol', (err,rows,fields) => {
      if(!err){
        res.json(rows);
        console.log(res);
      }else{
        console.log(err);
      }
    })
}); */
// Buscar rol con el parametro id que se le pasa en la direccion
router.get('/:id',(req, res)=>{
  const{id}=req.params
  conexion.query('SELECT * FROM  rol where Id_Rol=? ',[id],(err, rows, fields)=>{
      if(!err){
          res.json(rows);
        }else{
          console.log(err);
        }
  })
});
//crear rol
router.post('/', (req,res)=>{
  const { Nombre_Rol, Descripcion}= req.body;
  conexion.query(`INSERT INTO rol (Nombre_Rol, Descripcion) VALUES ('${Nombre_Rol}','${Descripcion}')`,
  (err, rows, fields)=>{
    if (err) throw err;
    else{
        res.json({status:'Rol Agregado'})
        console.log('Rol Agregado');
    }
  })
});
//eliminar 
router.delete('/:id',(req, res)=>{
  const{id} = req.params
  let sql =`delete from rol where Id_Rol = '${id}'`
  conexion.query(sql, (err, rows, fields)=>{
      if(err) throw err
      else{
          res.json({status: 'Rol eliminado'})
      }
  })
});
//modificar
router.put('/:id',(req, res)=>{
  const{id}=req.params
  const { Nombre_Rol, Descripcion}= req.body;
  let sql = `update rol set 
              Nombre_Rol ='${Nombre_Rol}',
              Descripcion='${Descripcion}'
              where Id_Rol = '${id}'`  
  conexion.query(sql, (err, rows, fields)=>{
      if(err) throw err
      else{
          res.json({status: 'Rol modificado'})
      }
  })
});


module.exports = router;