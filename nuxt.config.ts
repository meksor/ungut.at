import { resolve } from 'path'

// https://nuxt.com/docs/guide/directory-structure/nuxt.config#nuxt-config-file

export default defineNuxtConfig({
  compatibilityDate: '2024-08-15',

  modules: ['@nuxt/content', "@nuxt/image"],
  srcDir: 'src/',
  ssr: false,
  content: {
    sources: {
      content: {
        driver: 'fs',
        prefix: '/projects', // All contents inside this source will be prefixed with `/docs`
        base: resolve(__dirname, 'content/projects')
      }
    }
  },
})