<script setup lang="ts">
const props = withDefaults(defineProps<{
	value: number
	max: number
	color?: string
}>(), {
	value: 0,
	max: 100,
	color: '#e11d48',
})
</script>

<template>
	<progress class="align-baseline relative w-full overflow-hidden h-2 rounded-full " v-bind="props" />
</template>

<style scoped>
progress::-webkit-progress-bar {
    @apply bg-gray-100 dark:bg-white/20
}

progress::-webkit-progress-value {
    @apply rounded-full;
	background-color: v-bind(color);
}
</style>
