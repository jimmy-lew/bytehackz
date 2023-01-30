<script setup lang="ts">
const props = defineProps<{
	label: string
	action?: (...args: any[]) => any
	hasTopBorder?: boolean
}>()

const emits = defineEmits<{
	(e: 'action', event: MouseEvent): void
}>()

const handleClick = (event: MouseEvent) => {
	if (props.action) props.action()
	emits('action', event)
}
</script>

<template>
	<li class="flex items-center p-1 border-[#e5e7eb] dark:border-white/20" :class="{ 'border-t': hasTopBorder }" @click="handleClick">
		<div class="py-2 px-4 w-full text-sm hover:bg-[#e5e7eb] dark:hover:bg-[#18181b] rounded-md">
			{{ label }}
		</div>
	</li>
</template>

<style scoped>

</style>
