var http = require('http'),
    fs = require('fs'),
    tmpl = fs.readFileSync('index.html', 'utf8');

server = http.createServer(function(req, res) {
  if (req.url == '/') {
    res.writeHead(200, {'Content-Type': 'text/html'})
    res.end(tmpl)
  } else {
    for (var i = 0; i < 90000000; i++) {}
    res.writeHead(200, {'Content-Type': 'application/json'})
    res.end(JSON.stringify({hello: 'world'}))
  }
});

server.listen(8000);