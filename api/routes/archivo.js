const express = require("express");
const router = express.Router();
// invoca la conexion
const conexion = require("../config/conexion");
// token para las peticiones a mysql
const jwt = require("jsonwebtoken");
const multer = require("../config/multer");

// check tocken
router.use(function (req, res, next) {
  //Validate users access token on each request to our API.
  var token = req.headers.authorization.split(" ")[1];
  if (token) {
    jwt.verify(token, "MCG", function (err, decoded) {
      if (err) {
        return res.status(403).send({
          success: false,
          message: "Authorization required.",
        });
      } else {
        const content = jwt.verify(token, "MCG");
        req.data = content;
        next();
      }
    });
  } else {
    res.status(403).send({
      success: false,
      message: "No token provided.",
    });
    next();
  }
});

router.post("/", multer.array("uploads", 10), (req, res, next) => {
  const files = req.files;

  if (files.length === 0) {
    const error = new Error("Please upload a file");
    error.httpStatusCode = 400;
    return next(error);
  }
  if (!Array.isArray(files)) {
    res.status(400).json({});
  }
    files.forEach(async (file, index) => {
      let { idCategoria, idarea } = JSON.parse(
        Array.isArray(req.body.file) ? req.body.file[index] : req.body.file
      );
      let sql = `CALL CrearArchivo('${file.originalname}','${file.filename}','${String("uploads/" + file.filename)}','${idCategoria}','${idarea}');`;
        console.log(sql);
        
      conexion.query(sql, (err, rows, fields) => {
        if (err) {
          console.log("[ERROR]", err);
          res.status(400).json({ message: "Error upload file" });
        }
        /* res.json(rows[0]); */
        console.log(rows);
      });
    });
    
    res.json({ 
        TIPO: 3,
        MENSAJE: 'Se ha registrado de forma exitosa el archivo'
       });
    console.log("[INFO] UPLOAD DATA: OK"); 
});

router.get("/", (req, res) => {
  conexion.query("CALL `ListarArchivos`()", (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    }
  });
});

router.delete("/", (req, res) => {
  const { id } = req.body;
  conexion.query(`CALL EliminarArchivo('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    } else {
      res.json(err);
    }
  });
});

module.exports = router;
