const express= require('express');
const router= express.Router();
// invoca la conexion
const conexion = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

// enviar mas de un parametro (/:id/:nombre)
//se obtiene con el req.params.id, req.params.nombre

//listar todos
router.get('/', (req,res)=>{
  conexion.query('CALL `ConsultarInmueble`()', (err,rows,fields) => {
    if(!err){
      res.json(rows);
    }else{
      console.log(err);
    }
  })
});
//listar por proyecto
router.get('/proyecto/:id', (req,res)=>{
  const{id}=req.params
  conexion.query('SELECT * FROM inmueble where Fk_Id_Proyecto=?', [id],(err,rows,fields)=>{
    if(!err){
      res.json(rows);
    }else{
      console.log(err);
    }
  })
});
//Buscar inmueble
router.get('/:id', (req,res)=>{
  const{id}=req.params
  conexion.query('SELECT * FROM inmueble where Id_Inmueble=?', [id],(err, rows, fields)=>{
    if(!err){
      res.json(rows);
    }else{
      console.log(err);
    }
  })
});
//crear
router.post('/', (req,res)=>{
  const {Manzana, Num_Casa, Valor_Inicial, Ficha_Catastral, Escritura, Matricula_inmobiliaria, Estado, Fk_Id_Proyecto}= req.body;
  conexion.query(`INSERT INTO inmueble (Manzana, Num_Casa,Valor_Inicial, Ficha_Catastral, Escritura, Matricula_inmobiliaria, Estado, Fk_Id_Proyecto) VALUES ('${Manzana}','${Num_Casa}','${Valor_Inicial}','${Ficha_Catastral}','${Escritura}','${Matricula_inmobiliaria}','${Estado}','${Fk_Id_Proyecto}')`, 
  (err, rows, fields)=>{
    if (err) throw err;
    else{
      res.json({status:'Inmuble agregado'})
    }
  })
});
//eliminar 
router.delete('/:id',(req, res)=>{
  const{id} = req.params
  let sql =`delete from inmueble where Id_Inmueble = '${id}'`
  conexion.query(sql, (err, rows, fields)=>{
      if(err) throw err
      else{
          res.json({status: 'Inmueble eliminado'})
      }
  })
});
//modificar
router.put('/:id',(req, res)=>{
  const{id}=req.params
  const {Manzana, Num_Casa, Valor_Inicial, Ficha_Catastral, Escritura, Matricula_inmobiliaria, Estado, Fk_Id_Proyecto}= req.body;
  let sql = `update inmueble set 
              Manzana ='${Manzana}',
              Num_Casa='${Num_Casa}',
              Valor_Inicial ='${Valor_Inicial}',
              Ficha_Catastral='${Ficha_Catastral}',
              Escritura ='${Escritura}',
              Matricula_inmobiliaria='${Matricula_inmobiliaria}',
              Estado ='${Estado}',
              Fk_Id_Proyecto='${Fk_Id_Proyecto}'
              where Id_Inmueble = '${id}'`  
  conexion.query(sql, (err, rows, fields)=>{
      if(err) throw err
      else{
          res.json({status: 'Inmueble modificado'})
      }
  })
});

module.exports = router;