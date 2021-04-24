process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const { merge } = require('@rails/webpacker')
const webpackConfig = require('./base')

const testConfig = {
  resolve: {
    fallback: {
      util: require.resolve('util')
    }
  }
}

module.exports = merge(webpackConfig, testConfig)
