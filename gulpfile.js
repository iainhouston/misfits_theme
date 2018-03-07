var browserSync, cssSources, drupalPHPSources, drupalTemplateSources, drushAlias, gulp, postcss, reload, shell, test_site_name;

drushAlias = '@misdev8';

test_site_name = 'vagrant.misfitstheatre.test';

cssSources = ['sourcecss/**/*.css'];

drupalPHPSources = ['**/*.{php,inc}'];

drupalTemplateSources = ['**/*.html.twig'];

gulp = require('gulp');

shell = require('gulp-shell');

postcss = require('gulp-postcss');

browserSync = require('browser-sync').create();

reload = browserSync.reload;

gulp.task('drushPHP', shell.task(["drush " + drushAlias + " cr"]));

gulp.task('drushTwig', shell.task(["drush " + drushAlias + " cache-clear theme-registry"]));

gulp.task('css', function() {
  return gulp.src('sourcecss/style.css').pipe(postcss([require('postcss-import')(), require('postcss-url')(), require('postcss-cssnext')(), require('postcss-browser-reporter')(), require('postcss-reporter')()])).pipe(gulp.dest('./postcss')).pipe(reload({
    stream: true
  }));
});

gulp.task('watch-server', ['css', 'drushPHP', 'drushTwig'], function() {
  browserSync.init({
    proxy: test_site_name,
    reloadOnRestart: true,
    browser: '/Applications/FirefoxDeveloperEdition.app'
  });
  gulp.watch(cssSources, ['css']);
  gulp.watch(drupalPHPSources, ['drushPHP']);
  gulp.watch(drupalTemplateSources, ['drushTwig'], reload);
});

gulp.task('default', ['watch-server']);
