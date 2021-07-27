const mysql = require('mysql');
const conexion=mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'mcgconstrucciones',
    database: 'mcgdb'
});

conexion.connect((err)=>{
    if(err){
        console.log('error en conexxion: '+ err)
    }
    else{
        console.log('Conexion Exitosa!!!')
    }
});

module.exports = conexion;

/* Ejecute la siguiente consulta en la Base De datos

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mcgconstrucciones';

Dónde como usuario como url y como contraseñarootlocalhostpassword

A continuación, ejecute esta consulta para actualizar los privilegios:

flush privileges;

Intente conectarse mediante el nodo después de hacerlo.

Si eso no funciona, pruébalo sin parte.@'localhost' */