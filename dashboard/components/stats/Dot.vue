<script setup lang="ts">
withDefaults(defineProps<{
	color: string
}>(), {
	color: 'bg-emerald-500',
})
</script>

<template>
	<div class="flex items-center">
		<span class="mr-2 h-2 w-2 rounded-full" :class="color" />
		<div>
			<slot />
		</div>
	</div>
</template>

<style scoped>

</style>
