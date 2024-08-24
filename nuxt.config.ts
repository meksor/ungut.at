import { resolve } from 'path'

// https://nuxt.com/docs/guide/directory-structure/nuxt.config#nuxt-config-file

export default defineNuxtConfig({
  compatibilityDate: '2024-08-15',

  modules: ['@nuxt/content', "@nuxt/image", '@nuxthq/studio'],
  srcDir: 'src/',
  ssr: false,
  css: ["@/assets/scss/fonts.scss"],
  content: {
    sources: {
      content: {
        driver: 'fs',
        prefix: 'projects',
        base: resolve(__dirname, 'content/projects')
      }
    }
  },
  vite: {
    build: {
    }
  }
})