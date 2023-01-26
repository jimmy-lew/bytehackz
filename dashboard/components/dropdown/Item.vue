<script setup lang="ts">
defineProps<{
	label: string
	link: string
	hasTopBorder?: boolean
}>()
</script>

<template>
	<li class="flex items-center p-1" :class="{ 'border-t': hasTopBorder }">
		<NuxtLink :to="link" class="py-2 px-4 w-full text-sm">
			{{ label }}
		</NuxtLink>
	</li>
</template>

<style scoped>

</style>
