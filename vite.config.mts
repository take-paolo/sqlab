import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue2'
import FullReload from 'vite-plugin-full-reload'
import path from 'path'

export default defineConfig({
  base: '/vite-dev/',
  plugins: [
    RubyPlugin(),
    vue(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 200 }),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './app/javascript'),
      vue: 'vue/dist/vue.esm.js', // Use full build with template compiler
    },
    extensions: ['.mjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue'],
  },
  server: {
    hmr: {
      host: 'localhost',
    },
  },
})
