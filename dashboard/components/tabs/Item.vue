<script setup lang="ts">
const props = withDefaults(defineProps<{
	link?: string
	isBordered?: boolean
	action?: (...args: any[]) => any
}>(), {
	link: '/',
	isBordered: false,
	action: () => {},
})

const emits = defineEmits<{
	(e: 'action', event: MouseEvent): void
}>()

const path = usePath()

const isActiveRoute = computed(() => path.value === props.link)

const classes = computed(() => {
	const classes = []

	classes.push(isActiveRoute.value ? 'border-b-rose-600' : 'border-b-transparent')
	classes.push(isActiveRoute.value ? 'font-bold' : '')
	classes.push(props.isBordered ? 'border bordered' : 'border-b')

	return classes.join(' ')
})

const handleClick = (event: MouseEvent) => {
	if (props.action) props.action()
	emits('action', event)
}
</script>

<template>
	<div class="tab select-none relative inline-flex flex-wrap justify-center text-sm px-4 py-3 transition-all duration-300 ease-in" :class="classes">
		<NuxtLink v-if="link" :to="link">
			<slot />
		</NuxtLink>
		<div v-else @click="handleClick">
			<slot />
		</div>
	</div>
</template>

<style scoped>

</style>
