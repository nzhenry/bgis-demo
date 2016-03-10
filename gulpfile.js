var gulp = require('gulp');
var http = require('http');
var connect = require('connect');
var serveStatic = require('serve-static');
var webdriver = require('gulp-webdriver');
var fs = require('fs');

var httpServer;

gulp.task('start', function(done) {
  var app = connect().use(serveStatic('site'));
  httpServer = http.createServer(app).listen(9000, done);
});

gulp.task('test', function() {
	var dir = './test_reports';
	if (!fs.existsSync(dir)){
    fs.mkdirSync(dir);
	}
  return gulp.src('wdio.conf.js')
    .pipe(webdriver()).on('error', function() {
      process.exit(1);
    });
});
