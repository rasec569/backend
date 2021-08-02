const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const cors = require('cors');

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(cors());

//Routes
const userRoute = require('./api/routes/user');
const rolRoute =require('./api/routes/rol');
const areaRoute =require('./api/routes/area');

app.use('/user',userRoute);
app.use('/rol', rolRoute);
app.use('/area',areaRoute);

module.exports = app;