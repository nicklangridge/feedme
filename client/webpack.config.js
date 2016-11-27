var webpack = require('webpack');

module.exports = {
  devtool: 'source-map',
  entry: {
    main: [
      './scripts/main.js',
      'webpack-dev-server/client?http://localhost:8080',
    ],
  },
  output: {
    publicPath: 'http://localhost:8080/',
    filename: '/js/[name].js',
  },
  module: {
    loaders: [
      { test: /\.js$/, loaders: ['babel?' + JSON.stringify({presets: ['react', 'es2015', 'stage-0']})], exclude: /node_modules/ },
      { test: /\.scss$/, loaders: ['style', 'css', 'postcss', 'sass'] },
    ],
  }
};
