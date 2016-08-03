/* To Do List Demo App
 * server.js
 * Anjay Ajodha
 * From Chris Sevilleeja (scotch.io)
 * Microsoft Corporation 2015 
 */

var express = require('express');
var cv = require('opencv');
var app = express();
var mongoose = require('mongoose');
var morgan = require('morgan');
var bodyParser = require('body-parser');
var methodOverride = require('method-override');

mongoose.connect('mongodb://localhost/todo')

app.use(express.static(__dirname + '/public'));
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ 'extended': 'true' }));         // parse application/x-www-form-urlencoded
app.use(bodyParser.json());                                     // parse application/json
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json
app.use(methodOverride());

var fs = require('fs'),
    request = require('request');

var childproc = require('child_process');

var download = function(uri, filename, callback){
  request.head(uri, function(err, res, body){
    console.log('content-type:', res.headers['content-type']);
    console.log('content-length:', res.headers['content-length']);

    request(uri).pipe(fs.createWriteStream(filename)).on('close', callback);
  });
};

var imageUrl = 'https://azurepicfrompi.blob.core.windows.net/picontainer/pic.jpg';
//http://i.imgur.com/ijrOrher.jpg

app.get('*', function (req, res) {
    
    download(imageUrl, './public/siteimage.jpg', function(){
    console.log('done');
    });
    download(imageUrl, './public/sourceimage.jpg', function(){
    console.log('done');
    cv.readImage("./public/siteimage.jpg", function(err, im){
    im.detectObject(cv.FACE_CASCADE, {}, function(err, faces){
    for (var i=0;i<faces.length; i++){
       var x = faces[i]
       im.rectangle([x.x,x.y], [x.width,x.height], [0,255,0], 10);
     }
    im.save('./public/out.jpg');
    res.sendFile('./public/index.html');
        
    });
    });
    
    });
    
  
    
});

//Listening for input
app.listen(8080);
console.log("Listening on 8080");

