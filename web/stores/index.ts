import { defineStore } from 'pinia'

export const useAppStore = defineStore('app', () => {
	const name = ref('Jimmy')

	return { name }
})
