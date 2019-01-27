var webpack = require('webpack');
const path = require('path');

module.exports = {
  devtool: 'source-map',
  entry: {
    main: [
      './scripts/main.js',
    ],
  },
  output: {
    path: path.join(__dirname, '/dist/'),
    filename: '/js/[name].js',
    publicPath: '/'
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
    disableHostCheck: true
  },
  plugins: [
    new webpack.optimize.CommonsChunkPlugin('common.js'),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin(),
    new webpack.optimize.AggressiveMergingPlugin()
  ]  
};
