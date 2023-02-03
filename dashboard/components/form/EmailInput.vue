<script setup lang="ts">
defineProps<{
	placeholder?: string
	error?: string
}>()

const emits = defineEmits(['inputChange'])

const input = ref('')
</script>

<template>
	<div class="relative flex flex-col w-full focus:outline-0">
		<input
			v-model="input"
			tabindex="0"
			class="w-full bg-transparent focus:bg-[#141418] focus:scale-105 transition-all ease-in-out duration-300 hover:bg-[#141418] rounded focus:outline-0 pl-0 sm:pl-1 p-1"
			type="email"
			:placeholder="placeholder ? placeholder : 'Empty...'"
			:class="error ? 'error' : ''"
			@change="() => emits('inputChange', input)"
		>
		<span v-if="error" class="absolute top-1/2 right-0 -translate-y-1/2 text-xs px-1 text-error">
			{{ error }}
		</span>
	</div>
</template>

<style scoped>
.error {
    @apply outline-[0.5px] outline outline-error text-error;
}

.error::placeholder {
    @apply text-error text-xs sm:text-sm
}
</style>
