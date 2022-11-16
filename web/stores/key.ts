import { defineStore } from 'pinia'

export const useKeyInputStore = defineStore('key', () => {
	const input = ref('')
	function appendInput(char: string) {
		input.value += char
	}
	function clearInput() {
		input.value = ''
	}
	function backspace() {
		input.value = input.value.substring(0, input.value.length - 1)
	}

	return { input, appendInput, clearInput, backspace }
})
