/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./assets/**/*.css",
    "./components/*.{vue,js}",
    "./components/**/*.{vue,js}",
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
  plugins: [require('daisyui')],
}
