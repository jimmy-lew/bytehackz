// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
    modules: [
      '@nuxtjs/tailwindcss',
      '@nuxtjs/color-mode',
      '@vueuse/nuxt',
      'nuxt-icon'
    ],
    colorMode: {
      preference: 'dark', // default theme
      dataValue: 'theme', // activate data-theme in <html> tag
      classSuffix: '',
    }
  }
);