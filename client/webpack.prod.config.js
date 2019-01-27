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
  devServer: {
    host: '0.0.0.0',
    historyApiFallback: {
      index: 'index.html'
    },
    disableHostCheck: true
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

// https://medium.com/a-beginners-guide-for-webpack-2/copy-all-images-files-to-a-folder-using-copy-webpack-plugin-7c8cf2de7676