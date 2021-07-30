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
app.use('/user',userRoute);
app.use('/rol', rolRoute);

module.exports = app;