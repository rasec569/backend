var mysql = require('mysql');

var pool = mysql.createPool({
    connectionLimit: 20,
    host: '192.232.221.82',
    user: 'ampublic_mcgsoft',
    password: 'XSGGXKe=385[',
    database: 'ampublic_mcgcartera',
    /* 
    host: 'localhost',
    user: 'root',
    password: 'mcgconstrucciones',
    database: 'mcgdb', */
    options: {
        'charset': 'utf8mb4',
    }
});

module.exports = pool;