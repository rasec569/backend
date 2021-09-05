const mysql = require('mysql');

const util = require('util')

const conexion=mysql.createPool({
    connectionLimit: 10,
    host: '72.167.41.112',
    user: 'mitch',
    password: 'Hj-b!HGr3Z%d',
    database: 'mcgdb'

    /* host: '192.232.221.82',
    user: 'ampublic_mcgsoft',
    password: 'XSGGXKe=385[',
    database: 'ampublic_mcgcartera' */

});

conexion.getConnection((err, connection) => {
    if (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('Database connection was closed.')
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('Database has too many connections.')
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('Database connection was refused.')
        }
    }
    if (connection){
        connection.release();
        console.log("Successful connection!")
    } 
    return
});

// Promisify for Node.js async/await.
conexion.query = util.promisify(conexion.query)
module.exports = conexion;

/* Ejecute la siguiente consulta en la Base De datos

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mcgconstrucciones';

Dónde como usuario como url y como contraseñarootlocalhostpassword

A continuación, ejecute esta consulta para actualizar los privilegios:

flush privileges;

Intente conectarse mediante el nodo después de hacerlo.

Si eso no funciona, pruébalo sin parte.@'localhost' */