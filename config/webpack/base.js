const { webpackConfig, merge } = require('@rails/webpacker')
const customConfig = require('./custom')

webpackConfig.module.rules.map(module => { // lets iterate Rules...
  if (module.test && module.test.toString().includes('css')) {
    module.use.splice(-1, 0, {
      loader: require.resolve('resolve-url-loader')
    })
  }
  return module;
});

module.exports = merge(webpackConfig, customConfig)
