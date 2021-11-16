const multer = require('multer');
const { v4: uuidv4 } = require('uuid');
const path = require('path');

const storage = multer.diskStorage({
  destination: path.join('uploads'), //Establecemos donde se va a guardar la imagen
  filename: (req, file, cb) => {
      cb(null, uuidv4()+ path.extname(file.originalname)); //Guardamos la imagen con un indentificador unico agregandole la extension
  }
});


const multerConfig = multer({
  storage,
  limits: {fileSize: 2000000}, //Limite del tamaño de la imagen
  //dest: path.join(__dirname, 'uploads'),
  fileFilter: (req, file, callback) => {
      const filetypes = /jpeg|jpg|png|pdf/;
      const mimetype = filetypes.test(file.mimetype); //Valido que la extencion de la imagen se encuentre entre las validas
      const extname = filetypes.test(path.extname(file.originalname)); //extname() -> Devuelve la extencion 
      if(mimetype && extname){
          return callback(null, true);
      }
      callback("Error el archivo no es valido.")
  }
});


module.exports = multerConfig;
