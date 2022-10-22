// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
    css: ["@/assets/css/base.css"],
    build: {
      postcss: {
        postcssOptions: require("./postcss.config.js"),
      },
    },
  });
  