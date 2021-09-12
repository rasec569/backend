const express= require('express');
const router= express.Router();
// invoca la conexion
const conexion = require('../config/conexion');

// token para las peticiones a mysql
const jwt = require('jsonwebtoken');

//validar usuario
router.post('/', (req,res) => {
    const { Usuario, password } = req.body;
    conexion.query(`CALL ConsultarSesionUsuario('${Usuario}', '${password}')`, 
    [Usuario, password ], 
    (err, rows, fields)=>{
        if(!err){
            if(rows.length>0){                
                let data=JSON.stringify(rows[0]);
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

module.exports = router;