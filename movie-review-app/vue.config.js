const { defineConfig } = require('@vue/cli-service');

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    proxy: 'http://movie_web:3001', // Proxy requests to Rails backend
    port: 8080, // Port for Vue.js dev server
    host: '0.0.0.0', // Allow connections from outside Docker
  },
});
