module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		less: {
			development: {
				options: { paths: ["bower_components/bootstrap/less/","assets/less/"] },
				files: {
					"assets/css/site.css": "assets/less/site.less"
				}
			}
		},
		watch: {
			css: {
				files: 'assets/less/**/*.less',
				tasks: ['less'],
				options: { livereload: true},
			},
		},
	});

	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-watch');
};