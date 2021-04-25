module.exports = {
  module: {
    rules: [
      {
        test: require.resolve('cash-dom'),
        loader: 'expose-loader',
        options: {
          exposes: '$'
        }
      }
    ]
  }
}
