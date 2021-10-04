const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const cors = require('cors');

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(cors());
app.options('*', cors());
app.use(express.static('uploads'));
app.use('/uploads', express.static('uploads'));
//Routes
const userRoute = require('./api/routes/user');
const loginRoute = require('./api/routes/login');
const archivoRoute = require('./api/routes/archivo');
const clientsRoute = require('./api/routes/clients');
const rolRoute =require('./api/routes/rol');
const areaRoute =require('./api/routes/area');
const categoriaRoute =require('./api/routes/categoria');
const proyectoRoute= require('./api/routes/proyecto');
const inmuebleRoute= require('./api/routes/inmueble');
const etapaRoute= require('./api/routes/etapa');
const adicionalRoute= require('./api/routes/adicional');
const costoRoute= require('./api/routes/costo');
const acreedorRoute = require('./api/routes/acreedor');
const egresoRoute = require('./api/routes/egreso');
const carteraRoute = require('./api/routes/cartera');

app.use('/user',userRoute);
app.use('/login',loginRoute);
app.use('/archivo',archivoRoute);
app.use('/area',areaRoute);
app.use('/rol', rolRoute);
app.use('/proyecto', proyectoRoute);
app.use('/inmueble', inmuebleRoute);
app.use('/clients',clientsRoute);
app.use('/adicional',adicionalRoute);
app.use('/etapa',etapaRoute);
app.use('/categoria',categoriaRoute);
app.use('/costo',costoRoute);
app.use('/acreedor', acreedorRoute);
app.use('/egreso',egresoRoute);
app.use('/cartera',carteraRoute);

module.exports = app;