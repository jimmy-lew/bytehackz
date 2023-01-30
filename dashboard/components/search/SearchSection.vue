<script setup lang="ts">
defineProps<{
	title: string
}>()
</script>

<template>
	<div class="px-4 w-full py-1 text-xs font-semibold">
		{{ title.toUpperCase() }}
		<div class="flex flex-col items-center justify-center py-2 text-base font-normal">
			<slot />
		</div>
	</div>
</template>

<style scoped>

</style>
