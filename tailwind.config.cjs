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
	plugins: [
		require("daisyui")
	],
}
