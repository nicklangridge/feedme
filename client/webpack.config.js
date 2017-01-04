var webpack = require('webpack');
const path = require('path');

module.exports = {
  devtool: 'source-map',
  entry: {
    main: [
      './scripts/main.js',
      'webpack-dev-server/client?http://0.0.0.0:8080',
      'webpack/hot/only-dev-server',
    ],
  },
  output: {
    publicPath: 'http://0.0.0.0:8080/',
    filename: '/js/[name].js',
  },
  module: {
    loaders: [
      { test: /\.js$/, loaders: ['babel'], exclude: /node_modules/ },
      { test: /\.scss$/, loaders: ['style', 'css', 'sass'] },
    ],
  },
  devServer: {
    host: '0.0.0.0',
    historyApiFallback: {
      index: 'index.html'
    },
  },

};
