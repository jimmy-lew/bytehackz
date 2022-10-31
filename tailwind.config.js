/** @type {import('tailwindcss').Config} */

const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    "./assets/**/*.css",
    "./components/*.{vue,js}",
    "./components/**/*.{vue,js}",
    "./layouts/**/*.{vue,js}",
    "./layouts/*.{vue,js}",
    "./pages/*.vue",
    "./pages/**/*.vue",
    "./plugins/**/*.{js,ts}",
    "./*.{vue,js,ts}",
    "./nuxt.config.{js,ts}",
  ],
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
			},
			lineHeight: {
				'0': '0'
			},
			boxShadow: {
				'right-md': '4px 0 6px 0 rgba(0,0,0,0.1),2px 0 4px 0 rgba(0,0,0,0.1)'
			},
			width: {
				'3/8': '37.5%',
				'5/8': '62.5%'
			},
			content: {
				'default': '""'
			},
			fontFamily: {
				sans: ['Inter var', ...defaultTheme.fontFamily.sans],
			},
		},
	},
	daisyui: {
		themes: [
			{
				dark: {
					'primary': '#292E34',
					'secondary': '#FF6600',
					'accent': '#09BB6F',
					'neutral': '#12171B',
					'base-100': '#000212', // #1c2324
					'base-content': '#f8fafc',
					'info': '#0ea5e9',
					'success': '#22c55e',
					'warning': '#f59e0b',
					'error': '#be123c',
				},
			},
			{
				light: {
					'primary': '#d6d1cb',
					'secondary': '#FF6600',
					'accent': '#09BB6F',
					'neutral': '#ede8e4',
					'accent-content': '#ede8e4',
					'base-100': '#DFDBE5',
					'info': '#0ea5e9',
					'success': '#22c55e',
					'warning': '#f59e0b',
					'error': '#be123c',
				},
			},
		],
	},
  plugins: [require('daisyui')],
}
