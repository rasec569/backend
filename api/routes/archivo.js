const express = require("express");
const router = express.Router();
const conexion = require("../config/conexion");
const multipart = require('connect-multiparty');

const multipartMiddleware = multipart({
    uploadDir: './uploads'
});
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