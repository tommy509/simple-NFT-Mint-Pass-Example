var http = require('http');
const request = require('request');
var express = require('express');
var app = express();
const bodyParser = require("body-parser");
const hbs = require('hbs');
const cors = require("cors");
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
var corsOptions = {
  origin: ["http://localhost:3000","http://localhost:4200","http://localhost"]
};
app.use(cors(corsOptions));
const path = require('path');
app.use('/', express.static(path.join(__dirname, '/public')));
app.set('/views', path.join(__dirname))
app.set('view engine', 'hbs')
hbs.registerPartials(__dirname + '/views/partials');
hbs.registerHelper('eq', (a, b) => a == b);
require('./app/routes/web.routes')(app);
require('./app/routes/nft.routes')(app);
const PORT = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require('socket.io')(server);
server.listen(PORT);
io.sockets.on('connection', function (socket) {
  socket.on('comment', function (data) {
    io.sockets.emit('broadcastComment', {
     data: data
     });
  });
});