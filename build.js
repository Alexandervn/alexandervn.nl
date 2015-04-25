var metalsmith = require('metalsmith'),
    branch = require('metalsmith-branch'),
    assets = require('metalsmith-assets'),
    templates = require('metalsmith-templates'),
    collections = require('metalsmith-collections'),
    markdown = require('metalsmith-markdown'),
    moment = require('moment'),
    serve = require('metalsmith-serve'),
    watch = require('metalsmith-watch'),
    gzip = require('metalsmith-gzip'),
    permalinks = require('metalsmith-permalinks');

metalsmith(__dirname)
.metadata({
    site: {
        title: 'Alexander van Noord',
        description: ''
    }
})
.source('./src/posts')
.destination('./build')
.use(collections({
    posts: {
        pattern: '!index.md',
        sortBy: 'date',
        reverse: true
    }
}))
.use(markdown())
.use(branch()
        .pattern('!index.md')
        .use(permalinks({
            pattern: ':date/:slug',
            date: 'YYYY/MM/DD'
        }))
)
.use(templates({
    'engine': 'swig',
    'directory': 'templates'
}))
.use(assets({
    'source': './src/assets',
    'destination': '.'
}))
//.use(gzip({
    //overwrite: false
//}))
.use(watch({
    livereload: false
}))
.use(serve({
    host: '0.0.0.0',
    port: 8080,
    verbose: true,
//    headers: {
//        'Content-Encoding': 'gzip'
//    }
}))
.use(function(files, metalsmith, done) {
    //console.log("metadata", metalsmith.metadata());
    done();
})
.build(function (error) {
    if (error) {
        console.log(error);
    } else {
        console.log('Site build complete!');
    }
});
