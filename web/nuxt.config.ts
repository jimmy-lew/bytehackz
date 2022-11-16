// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
	modules: [
		'@nuxtjs/tailwindcss',
		'@nuxtjs/color-mode',
		'@vueuse/nuxt',
		'@pinia/nuxt',
		'nuxt-icon',
	],
	colorMode: {
		preference: 'system', // default theme
		dataValue: 'theme', // activate data-theme in <html> tag
		fallback: 'dark',
		classSuffix: '',
	},
	imports: {
		autoImport: true,
		dirs: ['stores'],
	},
	runtimeConfig: {
		testSecret: '',
	},
},
)
