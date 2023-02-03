<script setup lang="ts">
const props = withDefaults(defineProps<{
	link?: string
	isBordered?: boolean
	isFiller?: boolean
	action?: (...args: any[]) => any
}>(), {
	isBordered: false,
	isFiller: false,
	action: () => {},
})

const emits = defineEmits<{
	(e: 'action', event: MouseEvent): void
}>()

const path = usePath()
const slots = useSlots()

const isActiveRoute = computed(() => path.value === props.link)
const isTextManuallySet = computed(() => !!slots.default)

const classes = computed(() => {
	const classes = []

	classes.push(isActiveRoute.value ? '!border-b-rose-600' : 'border-b-transparent')
	classes.push(isActiveRoute.value ? 'font-bold' : '')
	classes.push(props.isBordered ? 'border bordered dark:border-white/20' : 'border-b')
	classes.push(props.isFiller ? 'w-full text-transparent' : '')

	return classes.join(' ')
})

const handleClick = (event: MouseEvent) => {
	if (props.action) props.action()
	emits('action', event)
}

const pathSegments = computed(() => props.link ? getPathSegments(props.link) : [])
const displayText = computed(() => startingWithCapital(pathSegments.value[pathSegments.value.length - 1]))
</script>

<template>
	<div class="tab relative inline-flex flex-wrap justify-center text-sm px-4 py-3 focus:outline-0 transition-all duration-300 ease-in" :class="classes">
		<NuxtLink v-if="link" :to="link" class="focus:outline-none" @click="handleClick">
			<slot v-if="isTextManuallySet" />
			<span v-else>{{ displayText }}</span>
		</NuxtLink>
		<div v-else :tabindex="isFiller ? '' : '0'" @click="handleClick">
			<div v-if="isFiller">
				&#8205;
			</div>
			<slot v-else />
		</div>
	</div>
</template>

<style scoped>
.tab > * {
	@apply hover:font-bold focus:font-bold hover:scale-105 focus:scale-105 focus:outline-0 transition-all duration-300 ease-in-out
}
</style>
