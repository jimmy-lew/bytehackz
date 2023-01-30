<script setup lang="ts">
withDefaults(defineProps<{
	title?: string
	value?: number
	color?: string
	max?: number
}>(), {
	title: 'Sample stat',
	value: 0,
	color: '#e11d48',
	max: 100,
})
</script>

<template>
	<div class="-mb-1 flex justify-between text-sm">
		<span class="font-semibold">{{ title }}</span>
		<span>
			<span class="font-semibold">
				{{ value }}&nbsp;
			</span>
			<span class="text-gray-400">
				of {{ max }}
			</span>
		</span>
	</div>
	<Progress :value="value" :max="max" :color="color" />
</template>

<style scoped>

</style>
