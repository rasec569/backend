const express = require("express");
const router = express.Router();
const conexion = require("../config/conexion");
const multipart = require('connect-multiparty');

const multipartMiddleware = multipart({
    uploadDir: './uploads'
});

router.post('/', multipartMiddleware, (req, res, next) => {
    conexion.query(
        `CALL CrearArchivo('${req.files.null.originalFilename}', '${String(req.files.null.path).replace('uploads','')}', '${String(req.files.null.path).replace('uploads','uploads/')}')`,
        (err, rows, fields) => {
            if (!err) {
                res.json(rows[0]);
            }
        }
    );
});
router.get("/", (req, res) => {
    conexion.query("CALL `ConsultarArchivos`()", (err, rows, fields) => {
      if (!err) {
        res.json(rows[0]);
      }
    });
  });

router.delete("/", (req, res) => {
    const {
        id
    } = req.body;
    conexion.query(`CALL EliminarArchivo('${id}')`, (err, rows, fields) => {
        if (!err) {
            res.json(rows[0]);
        } else {
            res.json(err);
        }
    });
});

module.exports = router;