# project specific settings
drushAlias      = '@misdev8'
test_site_name  = 'vagrant.misfitstheatre.test'

cssSources   = [ 'sourcecss/**/*.css' ]
drupalPHPSources = [ '**/*.{php,inc}' ]
drupalTemplateSources = [ '**/*.html.twig' ]

# workflow process settings
gulp = require('gulp')
shell = require('gulp-shell')
postcss = require('gulp-postcss')
browserSync = require('browser-sync').create()
reload = browserSync.reload


gulp.task 'drushPHP', shell.task([ "drush #{drushAlias} cr" ])

gulp.task 'drushTwig', shell.task([ "drush #{drushAlias} cache-clear theme-registry" ])

gulp.task 'css', ->
  gulp.src('sourcecss/style.css')
  .pipe(postcss([
    require('postcss-import')()
    require('postcss-url')()
    require('postcss-cssnext')()
    require('postcss-browser-reporter')()
    require('postcss-reporter')()
  ]))
  .pipe(gulp.dest('./postcss'))
  .pipe reload(stream: true)
  return

gulp.task 'watch-server', [
  'css'
  'drushPHP'
  'drushTwig'
], ->
  browserSync.init
    proxy: test_site_name
    reloadOnRestart: true
    browser: '/Applications/FirefoxDeveloperEdition.app'
  gulp.watch cssSources,    [ 'css' ]
  gulp.watch drupalPHPSources, [ 'drushPHP' ]
  gulp.watch drupalTemplateSources, [ 'drushTwig' ], reload
  return

# Default task to be run with `gulp`
gulp.task 'default', [ 'watch-server' ]
return
