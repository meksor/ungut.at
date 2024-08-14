import { resolve } from 'path'

// https://nuxt.com/docs/guide/directory-structure/nuxt.config#nuxt-config-file

export default defineNuxtConfig({
  modules: ['@nuxt/content', "@nuxt/image"],
  srcDir: 'src/',
  ssr: false,
  content: {
    sources: {
      content: {
        driver: 'fs',
        prefix: '/articles',
        base: resolve(__dirname, 'content')
      }
    }
  }
}
)