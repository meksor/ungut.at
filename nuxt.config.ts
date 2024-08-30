import { resolve } from 'path'

export default defineNuxtConfig({
  compatibilityDate: '2024-08-15',

  modules: ['@nuxt/content', "@nuxt/image", '@nuxthq/studio'],
  srcDir: 'src/',
  ssr: false,
  css: ["@/assets/scss/fonts.scss", "@/assets/scss/utils.scss"],
  content: {
    documentDriven: true,
    sources: {
      projects: {
        driver: 'fs',
        prefix: 'projects', 
        base: resolve(__dirname, 'content/projects')
      },
      global: {
        driver: 'fs',
        prefix: 'global', 
        base: resolve(__dirname, 'content/global')
      }
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

