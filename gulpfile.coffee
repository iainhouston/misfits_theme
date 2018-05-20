# project specific settings
drushAlias      = '@misdev8'
drushExecutable = "$DREX"
test_site_name  = 'vagrant.misfitstheatre.test'
cssSources = ['sourcecss/**/*.css']
drupalPHPSources = [ '**/*.{php,inc,theme}' ]
drupalTemplateSources = [ '**/*.html.twig' ]

# workflow process settings
gulp = require('gulp')
shell = require('gulp-shell')
postcss = require('gulp-postcss')
pimport = require('postcss-import')
cssnext = require('postcss-cssnext')
browser_reporter = require('postcss-browser-reporter')
reporter = require('postcss-reporter')
browserSync = require('browser-sync').create()
reload = browserSync.reload

gulp.task 'drushPHP', shell.task([ "#{drushExecutable} #{drushAlias} cr" ])

gulp.task 'drushTwig', shell.task([ "#{drushExecutable} #{drushAlias} cache-clear theme-registry" ])

eporter = require('postcss-reporter')
gulp.task 'css', ->
  gulp.src('sourcecss/style.css').pipe(postcss([
    pimport
    cssnext
    reporter(
      plugins: []
      clearReportedMessages: false)
    browser_reporter
  ]))
  .pipe gulp.dest('./postcss')
  .pipe browserSync.stream()

gulp.task 'watch-server', [
  'css'
  'drushPHP'
], ->
  browserSync.init
    proxy: test_site_name
    reloadOnRestart: true
    browser: '/Applications/Firefox Developer Edition.app'
  gulp.watch cssSources,    [ 'css' ], reload
  gulp.watch drupalPHPSources, ['drushPHP'], reload
  gulp.watch drupalTemplateSources, ['drushPHP'], reload
  return

# Default task to be run with `gulp`
gulp.task 'default', [ 'watch-server' ]
