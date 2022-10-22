/** @type {import('tailwindcss').Config} */
module.exports = {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
	theme: {
		extend: {
			colors: {
				'astro-purple': '#7c3aed',
				'astro-pink': '#da62c4'
			},
			backgroundSize: {
				'400': '400%'
			},
			backgroundImage: {
				'astro-gradient': 'linear-gradient(45deg, #7c3aed, #da62c4 30%, white 60%)'
			},
			transitionTimingFunction: {
				'astro': 'cubic-bezier(0.22, 1, 0.36, 1)'
			}
		},
	},
	daisyui: {
		themes: [
			{
			mytheme: {
				"primary": "#d80812",
					
				"secondary": "#d8083c",
					
				"accent": "#0869d8",
					
				"neutral": "#000",
					
				"base-100": "#eee", //Change back to #eee
					
				"info": "#0ea5e9",
					
				"success": "#22c55e",
					
				"warning": "#f59e0b",
					
				"error": "#be123c",
				},
			},
		],
	},
	plugins: [
		require("daisyui")
	],
}
