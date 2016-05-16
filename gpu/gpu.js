var restify = require('restify');

var server = restify.createServer({
    name: 'alice',
    version: '1.0.0'
});
server.use(restify.acceptParser(server.acceptable));
server.use(restify.queryParser());
server.use(restify.bodyParser());

var logit = function(str) {
    ts = new Date().toISOString();
    console.log("%s - %s", ts, str);
};

server.get('/ping', function (req, res, next) {
    logit('/');
    res.send("GPU service up and running");
    return next();
});

server.get('/data', function (req, res, next) {
    logit('/');
    res.send("Streaming video data from the GPU ...");
    return next();
});

server.on('after', function (req, resp, route, err) {
    console.log(err);
});

server.listen(8080, function () {
    console.log('%s listening at %s', server.name, server.url);
});