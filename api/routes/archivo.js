const express = require("express");
const router = express.Router();
// invoca la conexion
const conexion = require("../config/conexion");
// token para las peticiones a mysql
const jwt = require("jsonwebtoken");
// save file
const multer = require('multer')
var path = require('path')
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads')
  },
  filename: function (req, file, cb) {
    cb(null, md5(Date.now()) + '-' + Date.now() + path.extname(file.originalname))
  }
})

var upload = multer({
  storage: storage
})

var md5 = require('md5');
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


/*router.post('/', multipartMiddleware, (req, res, next) => {
    conexion.query(
        `CALL CrearArchivo('${req.files.uploads[0].originalFilename}', '${String(req.files.uploads[0].path).replace('uploads','')}', '${String(req.files.uploads[0].path).replace('uploads','uploads/')}')`,
        (err, rows, fields) => {
            if (!err) {
                res.json(rows[0]);
            }
        }
    );
});*/
router.post('/', upload.single('uploads[]'), (req, res, next) => {
  const file = req.file;
  const {idCategoria,idarea} = JSON.parse(req.body.file);
  if (!file) {
    const error = new Error('Please upload a file')
    error.httpStatusCode = 400
    return next(error)
  }
  conexion.query(
    `CALL CrearArchivo('${req.file.originalname}', '${String(req.file.filename)}', '${String('uploads/'+req.file.filename)}','${String(JSON.parse(req.body.file).idCategoria)}','${String(JSON.parse(req.body.file).idarea)}')`,
    (err, rows, fields) => {
        if (!err) {
            res.json(rows[0]);
        }
    }
);
  //res.send(file)
   
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