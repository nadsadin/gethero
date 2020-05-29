const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')
const webpack = require('webpack');
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
}));
environment.loaders.get('sass').use.find(item => item.loader === 'sass-loader').options.sassOptions.includePaths = ['node_modules']
environment.loaders.get('sass').use.find(item => item.loader === 'sass-loader').options.implementation = require('sass')
environment.loaders.get('sass').use.find(item => item.loader === 'sass-loader').options.webpackImporter = true
environment.loaders.prepend('coffee', coffee)
module.exports = environment