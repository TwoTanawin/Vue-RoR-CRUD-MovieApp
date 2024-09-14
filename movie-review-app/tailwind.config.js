// tailwind.config.js
module.exports = {
  content: [
    './src/**/*.{html,js,vue,ts}',
  ],
  theme: {
    extend: {
      colors: {
        purple: {
          950: '#3e065f',
          850: '#542c85',
          500: '#6d28d9', // This is the default purple you can use
          300: '#a855f7',
        },
      },
    },
  },
  plugins: [],
};
