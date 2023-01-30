<script setup lang="ts">
withDefaults(defineProps<{
	title?: string
	value?: string | number
	description?: string
	icon?: string
}>(), {
	title: '',
	value: '',
	description: '',
	icon: '',
})
</script>

<template>
	<div class="stat flex flex-1 flex-col space-y-2 justify-self-center py-3 text-center bg-white dark:bg-base">
		<div class="flex items-center justify-center text-xs">
			<Icon size="16" class="mr-1" :name="icon" />
			{{ title }}
		</div>
		<div class="text-2xl font-semibold leading-5">
			{{ value }}
		</div>
	</div>
</template>

<style scoped>

</style>
