const colors = require('tailwindcss/colors');

module.exports = {
  purge: ['./src/**/*.{js,jsx,ts,tsx}', './public/index.html'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      storedog: '#1c5c92',
      'storedog-dark': '#1E4668',
      ...colors,
    },
    height: {
      logo: '75px',
    },
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
