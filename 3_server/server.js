var fs = require('fs');
var express = require('express');
var bodyParser = require('body-parser');
var app = express();

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(express.static('./.tmp'));

app.get('/api/PostStatusUpdate', function(req, res) {
    console.log('/api/PostStatusUpdate POST');
    console.log(req.body);
    res.json({
        "status": true,
        "message": "Open"
    });
});

app.listen(1337, function() {
    console.log('Server listening on port: 1337');
});
