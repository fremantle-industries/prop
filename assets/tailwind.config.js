const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  mode: 'jit',
  purge: [
    '../config/runtime.exs',
    '../lib/**/*.ex',
    '../lib/**/*.leex',
    '../lib/**/*.eex',
    '../deps/**/*.ex',
    '../deps/**/*.leex',
    '../deps/**/*.eex',
    './js/**/*.js',
    './js/**/*.jsx',
    './js/**/*.ts',
    './js/**/*.tsx'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        // Free Proxima Nova alternative
        sans: ['Montserrat', ...defaultTheme.fontFamily.sans],
      },
      width: {
        // /24
        '1/24': '4.16666666667%',
        '2/24': '8.33333333333%',
        '3/24': '12.5%',
        '4/24': '16.6666666667%',
        '5/24': '20.8333333333%',
        '6/24': '25%',
        '7/24': '29.1666666667%',
        '8/24': '33.3333333333%',
        '9/24': '37.5%',
        '10/24': '41.6666666667%',
        '11/24': '45.8333333333%',
        '12/24': '50%',
        '13/24': '54.16666666675%',
        '14/24': '58.3333333333%',
        '15/24': '62.5%',
        '16/24': '66.6666666667%',
        '17/24': '70.8333333333%',
        '18/24': '75%',
        '19/24': '79.1666666667%',
        '20/24': '83.3333333333%',
        '21/24': '87.5%',
        '22/24': '91.6666666667%',
        '23/24': '95.8333333333%',
        // /36
        '1/36': '2.77777777778%',
        '2/36': '5.55555555556%',
        '3/36': '8.33333333333%',
        '4/36': '11.1111111111%',
        '5/36': '13.8888888889%',
        '6/36': '16.6666666667%',
        '7/36': '19.4444444444%',
        '8/36': '22.2222222222%',
        '9/36': '25%',
        '10/36': '27.7777777778%',
        '11/36': '30.5555555556%',
        '12/36': '33.3333333333%',
        '13/36': '36.1111111111%',
        '14/36': '38.8888888889%',
        '15/36': '41.6666666667%',
        '16/36': '44.4444444444%',
        '17/36': '47.2222222222%',
        '18/36': '50%',
        '19/36': '52.7777777778%',
        '20/36': '55.5555555556%',
        '21/36': '58.3333333333%',
        '22/36': '61.1111111111%',
        '23/36': '63.8888888889%',
        '24/36': '66.6666666667%',
        '25/36': '69.4444444444%',
        '26/36': '72.2222222222%',
        '27/36': '75%',
        '28/36': '77.7777777778%',
        '29/36': '80.5555555556%',
        '30/36': '83.3333333333%',
        '31/36': '86.1111111111%',
        '32/36': '88.8888888889%',
        '33/36': '91.6666666667%',
        '34/36': '94.4444444444%',
        '35/36': '97.2222222222%',
      }
    },
  },
  variants: {
    display: ['responsive', 'empty'],
    extend: {
      opacity: ['disabled'],
      visibility: ['group-hover'],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('tailwindcss-empty-pseudo-class')()
  ],
}
