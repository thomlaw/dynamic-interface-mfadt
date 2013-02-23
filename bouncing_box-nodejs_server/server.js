var http = require("http");
var fs = require('fs'); // filesystem.
var path = require('path'); // used for traversing your OS.
var url = require('url');

// add to your hearts' content. lookup table, can add gif or zip, just google different mimeTypes
var mimeTypes = {
    "html": "text/html",
    "jpeg": "image/jpeg",
    "jpg": "image/jpeg",
    "png": "image/png",
    "js": "text/javascript",
    "css": "text/css"
};

// jk: more advanced: https://npmjs.org/package/mime
http.createServer(function(req,res) {
	var fileToLoad;

	// you could also convert a url to a filename like so if you wanted
	if(req.url == "/") {
		fileToLoad = "./index.html";
	}
	else {
		fileToLoad = "." + url.parse(req.url).pathname; 
	}

	var fileBytes;
	var httpStatusCode = 200; //status code 200 means OK

	// check to make sure a file exists...
	//helper for accessing file system, check if it exists
	fs.exists(fileToLoad,function(doesItExist) { //runs a function when it determines if a file exists, nothing else will happen before

		// if it doesn't exist lets make sure we load error404.html
		if(!doesItExist) {
			httpStatusCode = 404;
			fileToLoad = "error404.html"; //sending a file back to the user
		}
//****started here
		fileBytes = fs.readFileSync(fileToLoad);//synchronously
		//mimeType object, open straighbracket dead giveaway
		var mimeType = mimeTypes[path.extname(fileToLoad).split(".")[1]]; // complicated, eh?, splits the last part of the file to get the extension, "HTML"

		res.writeHead(httpStatusCode,{'Content-type':mimeType});
		res.end(fileBytes);
	});
}).listen(8080,'127.0.0.1');