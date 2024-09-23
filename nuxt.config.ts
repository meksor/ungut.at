import { resolve } from 'path'

export default defineNuxtConfig({
  compatibilityDate: '2024-08-15',
  app: {
    head: {
      titleTemplate: '%s - ungut.at',
    },
    layoutTransition: { name: 'layout', mode: 'in-out' }
  },
  modules: ['@nuxt/content', "@nuxt/image", '@nuxthq/studio'],
  srcDir: 'src/',
  ssr: true,
  routeRules: {
    '/**': { prerender: true, ssr: true },
  },
  css: ["@/assets/scss/main.scss", "@/assets/scss/utils.scss"],
  content: {
    documentDriven: true,
    sources: {
      global: {
        driver: 'fs',
        prefix: '', 
        base: resolve(__dirname, 'content')
      },
      
    }
  },
  vite: {
    build: {
    },
    css: {
      preprocessorOptions: {
        sass: {
          additionalData: '@import "@/assets/scss/variables.scss"',
        },
      },
    },
  }
})