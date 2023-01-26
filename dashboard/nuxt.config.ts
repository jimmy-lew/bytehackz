// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
	modules: [
		'@nuxtjs/tailwindcss',
		'@nuxtjs/color-mode',
		'nuxt-icon',
		'@vueuse/nuxt',
	],
	colorMode: {
		preference: 'dark', // default theme
		dataValue: 'theme', // activate data-theme in <html> tag
		fallback: 'dark',
		classSuffix: '',
	},
	app: {
		head: {
			charset: 'utf-16',
			viewport: 'width=device-width, initial-scale=1',
			title: 'ScamAlert Dashboard',
			meta: [
				{ name: 'description', content: 'Dashboard for tracking scams in realtime' },
			],
			link: [
				{ rel: 'icon', type: 'image/x-icon', href: '/favicon.svg' },
				{ rel: 'stylesheet', href: 'https://rsms.me/inter/inter.css' },
			],
			bodyAttrs: {
				class: 'dark:bg-[#0c0c0c]',
			},
		},
	},
})
