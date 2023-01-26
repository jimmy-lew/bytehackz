<script setup lang="ts">
const props = defineProps<{
	value: number
	max: number
}>()
</script>

<template>
	<progress class="align-baseline relative w-full overflow-hidden h-2 rounded-full " v-bind="props" />
</template>

<style scoped>
progress::-webkit-progress-bar {
    @apply bg-gray-300
}

progress::-webkit-progress-value {
    @apply bg-rose-600 rounded-full
}
</style>
