import { resolve } from 'path'

export default defineNuxtConfig({
  compatibilityDate: '2024-08-15',
  app: {
    head: {
      titleTemplate: '%s - ungut.at',
    },
    layoutTransition: { name: 'layout', mode: 'in-out' }
  },
  site: {
    url: 'https://ungut.at',
    name: 'Max Wolschlager - ungut.at',
    trailingSlash: true,
  },
  modules: [
    '@nuxt/content',
    "@nuxt/image",
    '@nuxthq/studio',
    'nuxt-mdi',
    '@nuxtjs/seo'
  ],
  srcDir: 'src/',
  ssr: true,
  routeRules: {
    '/**': { prerender: true, ssr: true },
    // "/api/**": { isr: false },
  },
  css: ["@/assets/scss/main.scss", "@/assets/scss/utils.scss"],
  nitro: {
    prerender: {
      routes: ['/', '/works/']
    }
  },
  build: {
    analyze: {},
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