const express= require('express');
const router= express.Router();
// invoca la conexion
const conexion = require('../config/conexion');
// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

// Listar usuarios
router.get('/ListarUser', (req,res)=>{
    conexion.query('SELECT * FROM usuario', (err,rows,fields) => {
      if(!err){
        res.json(rows);
      }else{
        console.log(err);
      }
    })
});
router.post('/NewUser', (req,res)=>{
  const { Nombres, Apellidos, Usuario, password, Celular, email, Rol, Area}= req.body;
  conexion.query(`INSERT INTO usuario (Nombre_Usuario, Apellido_Usuario, Usuario, Contraseña, Celular, email, Fk_Id_Rol, Fk_Id_Area) VALUES ('${Nombres}','${Apellidos}' ,'${Usuario}','${password}' ,'${Celular}','${email}' ,'${Rol}','${Area}')`,
  (err, rows, fields)=>{
    if (err) throw err;
    else{
        res.json({status:'Usuario Agregado'})
        console.log('Usuario Agregado');
    }
  })
  console.log('Llego al servicio', req.body);
})
//validar usuario
router.post('/signin', (req,res) => {
    const { Usuario, password } = req.body;
    /* console.log(req.body); */
    conexion.query('SELECT Usuario, Fk_Id_Rol  FROM  usuario where Usuario=? and Contraseña=?', 
    [Usuario, password ], 
    (err, rows, fields)=>{
        if(!err){
            console.log(rows);
            if(rows.length>0){                
                let data=JSON.stringify(rows[0]);
                //genera el token y la palabra secrecta
                const token= jwt.sign(data,'MCG');
                res.json({token});
            }else{
                res.json('Usuario o contraseña incorrectos');                
            }
          }else{
            console.log(err);
          }
    }
    )
});
router.post('/test', vericarToken, (req,res)=>{
    console.log(req.data);
    res.json('Inf secrect');
});

function vericarToken(req,res,next){
    if(!req.headers.authorization) return res.status(401).json('No autorizado');
    const token = req.headers.authorization.substr(7);
    if(token!==''){
        const content= jwt.verify(token,'MCG');
        req.data=content;
        next();
    }else{
        res.status(401).json('Token vacio');
    }
    /* console.log(token); */
}

  // Buscar usuario con el parametro id que se le pasa en la direccion
router.get('/:id',(req, res)=>{
    const{id}=req.params
    conexion.query('SELECT * FROM  usuario where Id_Usuario=? ',[id],(err, rows, fields)=>{
        if(!err){
            res.json(rows);
          }else{
            console.log(err);
          }
    })
});
module.exports = router;