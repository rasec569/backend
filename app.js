const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const cors = require('cors');

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(cors());

//Routes
const userRoute = require('./api/routes/user');
const loginRoute = require('./api/routes/login');
const clientsRoute = require('./api/routes/clients');
const rolRoute =require('./api/routes/rol');
const areaRoute =require('./api/routes/area');
const proyectoRoute= require('./api/routes/proyecto');
const inmuebleRoute= require('./api/routes/inmueble');
const etapaRoute= require('./api/routes/etapa');
const adicionalRoute= require('./api/routes/adicional');

app.use('/user',userRoute);
app.use('/login',loginRoute);
app.use('/area',areaRoute);
app.use('/rol', rolRoute);
app.use('/proyecto', proyectoRoute);
app.use('/inmueble', inmuebleRoute);
app.use('/clients',clientsRoute);
app.use('/adicional',adicionalRoute);
app.use('/etapa',etapaRoute);

module.exports = app;