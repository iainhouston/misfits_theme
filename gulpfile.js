// project specific settings
var browserSync, cssSources, drupalPHPSources, drupalTemplateSources, drushAlias, gulp, postcss, reload, shell, test_site_name;

drushAlias = '@misdev8';

test_site_name = 'vagrant.misfitstheatre.test';

cssSources = ['sourcecss/**/*.css'];

drupalPHPSources = ['**/*.{php,inc,theme}'];

drupalTemplateSources = ['**/*.html.twig'];

// workflow process settings
gulp = require('gulp');

shell = require('gulp-shell');

postcss = require('gulp-postcss');

browserSync = require('browser-sync').create();

reload = browserSync.reload;

gulp.task('drushPHP', shell.task([`drush ${drushAlias} cr`]));

gulp.task('drushTwig', shell.task([`drush ${drushAlias} cache-clear theme-registry`]));

gulp.task('css', function() {
  return gulp.src('sourcecss/style.css').pipe(postcss([require('postcss-import')(), require('postcss-url')(), require('postcss-nesting')({}), require('postcss-cssnext')(), require('postcss-browser-reporter')(), require('postcss-reporter')()])).pipe(gulp.dest('./postcss')).pipe(browserSync.stream());
});

gulp.task('watch-server', ['css', 'drushPHP', 'drushTwig'], function() {
  browserSync.init({
    proxy: test_site_name,
    reloadOnRestart: true,
    browser: '/Applications/Firefox Developer Edition.app'
  });
  gulp.watch(cssSources, ['css'], reload);
  gulp.watch(drupalPHPSources, ['drushPHP'], reload);
  gulp.watch(drupalTemplateSources, ['drushPHP'], reload);
});

// Default task to be run with `gulp`
gulp.task('default', ['watch-server']);
