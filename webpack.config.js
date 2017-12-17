module.exports = {
  entry: './src/index',

  output: 'bundle.js',

  resolve: {
    extensions: ['.ts', '.tsx', '.js', '.jsx', '.elm']
  },

  module: {
    loaders: [
      {
        test: /\.ts?$/,
        loader: 'awesome-typescript-loader'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: 'elm-webpack-loader',
          options: {},
        },
      },
    ],
  },
};
