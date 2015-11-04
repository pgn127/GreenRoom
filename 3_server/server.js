var fs = require('fs');
var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');
var app = express();

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(express.static('./.tmp'));
app.enable('trust proxy');

app.post('/api/PostStatusUpdate', function (req, res) {
    console.log('/api/PostStatusUpdate POST');
    console.log(req.body);
    res.json({
        "status": true,
        "message": "Open"
    });
});

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});

app.listen(1337, function() {
    console.log('Server listening on port: 1337');
});
