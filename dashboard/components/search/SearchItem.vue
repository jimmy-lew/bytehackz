<script setup lang="ts">
const props = defineProps<{
	data: Record<string, any>
	dataKey: string
	dataIcon: string
}>()

const {
	data,
	dataKey,
} = toRefs(props)

const { width } = useWindowSize()

const maxChars = computed(() => {
	if (width.value > 640) return 48
	if (width.value > 420) return 32
	if (width.value > 360) return 28
	return 20
})

const displayText = computed(() => {
	const text = data.value[dataKey.value]
	if (text.length > maxChars.value) return `${text.substring(0, maxChars.value)}...`
	return text
})
</script>

<template>
	<div tabindex="0" class="w-full rounded-md max-h-[72px] transition-all duration-300 ease-in hover:bg-[#18181b] hover:scale-[102.5%] focus:bg-[#18181b] focus:scale-[102.5%] focus:outline-0">
		<div class="flex justify-start items-center px-4 py-3 whitespace-pre-line text-white">
			<Card class="mr-2">
				<Icon size="12" :name="dataIcon" />
			</Card>
			{{ displayText }}
		</div>
	</div>
</template>

<style scoped>
</style>
