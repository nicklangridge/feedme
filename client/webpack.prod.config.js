var webpack = require('webpack');
var CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');

module.exports = {
  devtool: 'source-map',
  entry: {
    main: [
      './scripts/main.js',
    ],
  },
  output: {
    path: path.join(__dirname, '/build/'),
    filename: '/js/[name].js',
    publicPath: '/'
  },
  module: {
    loaders: [
      { test: /\.js$/, loaders: ['babel-loader?cacheDirectory'], exclude: /node_modules/ },
      { test: /\.scss$/, loaders: ['style-loader', 'css-loader', 'sass-loader'] },
    ],
  },
  externals: {
    config: JSON.stringify(require('./config/prod.json'))
  },
  plugins: [
    //new webpack.optimize.CommonsChunkPlugin('common.js'),
    //new webpack.optimize.DedupePlugin(),
    /*new webpack.optimize.UglifyJsPlugin({
      parallel: {
        cache: true,
        workers: 2,
      },
    }),*/
    //new webpack.optimize.AggressiveMergingPlugin(),
    new CopyWebpackPlugin([{from:'public', to:'./'}]), 
  ]  
};