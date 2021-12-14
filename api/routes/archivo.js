const express = require("express");
const router = express.Router();
// invoca la connection
const connection = require('../config/conexion');

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

router.post("/", multer.array("uploads", 10), async (req, res, next) => {
  const files = req.files;

  if (files.length === 0) {
    const error = new Error("Please upload a file");
    error.httpStatusCode = 400;
    return next(error);
  }
  if (!Array.isArray(files)) {
    res.status(400).json({});
  }
  await Promise.all(
    files.map(async (file, index) => {
      let { idCategoria, idarea } = JSON.parse(
        Array.isArray(req.body.file) ? req.body.file[index] : req.body.file
      );

      let sql = `CALL CrearArchivo('${file.originalname}','${file.filename}','${String("uploads/" + file.filename)}','${idCategoria}','${idarea}');`;
      console.log(sql);
        
      await connection.query(sql, (err, rows, fields) => {
        if (err) {
          console.log("[ERROR]", err);
          res.status(400).json({ message: "Error upload file" });
        }
        /* res.json(rows[0]); */
        console.log(rows);
      });
    })
  )
  
    // files.forEach(async (file, index) => {
    //   let { idCategoria, idarea } = JSON.parse(
    //     Array.isArray(req.body.file) ? req.body.file[index] : req.body.file
    //   );
    //   let sql = `CALL CrearArchivo('${file.originalname}','${file.filename}','${String("uploads/" + file.filename)}','${idCategoria}','${idarea}');`;
    //     console.log(sql);
        
    //   connection.query(sql, (err, rows, fields) => {
    //     if (err) {
    //       console.log("[ERROR]", err);
    //       res.status(400).json({ message: "Error upload file" });
    //     }
    //     /* res.json(rows[0]); */
    //     console.log(rows);
    //   });
    // });
    
    res.json({ 
        TIPO: 3,
        MENSAJE: 'Se ha registrado de forma exitosa el archivo'
       });
    console.log("[INFO] UPLOAD DATA: OK"); 
});

async function listarArchivos() {
  return new Promise((resolve, reject) => {
    connection.query("CALL `ListarArchivos`()", (err, rows, fields) => {
      if (!err) {
         resolve(rows[0]);
      }else {
        reject(err);
      }
    });
  })
}
async function EliminarArchivos() {
  return new Promise((resolve, reject) => {
    connection.query(`CALL EliminarArchivo('${id}')`, (err, rows, fields) => {
      if (!err) {
         resolve(rows[0]);
      }else {
        reject(err);
      }
    });
  })
}
router.get("/", async (req, res, next)=>{
 try {
   const result = await listarArchivos();
   res.json(result);
 } catch (error) {
   res.json(error);
 }
});

router.delete("/", async (req, res, next)=>{
  const { id } = req.body;
  connection.query(`CALL EliminarArchivo('${id}')`, (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
      console.log(rows[0]);
    } else {
      res.json(err);
      console.log(err);
    }
  });
});

module.exports = router;
