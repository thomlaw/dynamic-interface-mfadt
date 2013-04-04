var http = require("http");
var fs = require('fs');
var path = require('path');
var url = require('url');
var io = require("socket.io");

var mimeTypes = {
    "html": "text/html",
    "jpeg": "image/jpeg",
    "jpg": "image/jpeg",
    "png": "image/png",
    "js": "text/javascript",
    "css": "text/css"
};

var webroot = "./www";

var server = http.createServer(function(req,res) {
	var fileToLoad;

	fileToLoad = webroot + url.parse(req.url).pathname;

	// check if we're a directory...
	stats = fs.lstatSync(fileToLoad);
	if(stats.isDirectory()) {
		fileToLoad = fileToLoad + "index.html";
	}

	var fileBytes;
	var httpStatusCode = 200;

	// check to make sure a file exists...
	fs.exists(fileToLoad,function(doesItExist) {

		// if it doesn't exist lets make sure we load error404.html
		if(!doesItExist) {
			httpStatusCode = 404;
			fileToLoad = webroot + "error404.html";
		}

		fileBytes = fs.readFileSync(fileToLoad);
		var mimeType = mimeTypes[path.extname(fileToLoad).split(".")[1]]; // complicated, eh?

		res.writeHead(httpStatusCode,{'Content-type':mimeType});
		res.end(fileBytes);
	});
})

server.listen(8080,'127.0.0.1');


var socketServer = io.listen(server);
socketServer.sockets.on('connection',function(socket) {

	//when a client sends us an x coordinate
	socket.on('drawToServer1',function(data) {
		send =data;
		console.log( "received drawToServer1: " + send);

		socket.broadcast.emit("draw1",send);
		

	});

	//when a client sends us a y coordinate
	socket.on('drawToServer2',function(data) {
		send2 =data;
		console.log("recieved drawToServer2: " + send2);

		socket.broadcast.emit("draw2",send2);
		
	});






});