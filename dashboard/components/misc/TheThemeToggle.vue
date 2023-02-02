<script setup lang="ts">
const theme = useColorMode()
const icon = computed(() => {
	switch (theme.value) {
		case 'light':
			return 'heroicons:moon-20-solid'
		case 'dark':
			return 'heroicons:sun-20-solid'
		default:
			return 'heroicons:moon-20-solid'
	}
})

const change = () => theme.preference = theme.preference === 'light' ? 'dark' : 'light'
</script>

<template>
	<button class="flex items-center justify-between w-full rounded-md hover:bg-[#e5e7eb] dark:hover:bg-[#18181b] px-4 py-2" name="Theme toggle" @click="change">
		{{ startingWithCapital(theme.value) }}
		<div class="flex justify-center items-center">
			<Icon size="16" :name="icon" />
		</div>
	</button>
</template>

<style scoped>

</style>
