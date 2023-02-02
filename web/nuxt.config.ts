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
		preference: 'light', // default theme
		dataValue: 'theme', // activate data-theme in <html> tag
		fallback: 'light',
		classSuffix: '',
	},
	imports: {
		autoImport: true,
		dirs: ['stores', 'lib'],
	},
	runtimeConfig: {
		testSecret: '',
		firebaseProjectId: '',
		firebaseClientEmail: '',
		firebasePrivateKey: '',
	},
},
)
