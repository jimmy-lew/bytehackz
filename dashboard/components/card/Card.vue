<script setup lang="ts">
const props = withDefaults(defineProps<{
	radius?: number
	padding?: number
	round?: RoundTypes
	noGlow?: boolean
	noBorder?: boolean
	transparent?: boolean
	error?: boolean
}>(), {
	radius: 6,
	padding: 2,
	round: 'md',
	noGlow: false,
	noBorder: false,
	transparent: false,
	error: false,
})

const parentClass = computed(() => {
	const classes = ['card', `rounded-${props.round}`, `${props.noGlow || props.error ? '' : 'glow'}`, `${props.noBorder ? 'bg-white dark:bg-base' : 'bg-[#e5e7eb] dark:bg-white/20'}`, `${props.error ? '!bg-error' : ''}`]
	return classes.join(' ')
})

const childClass = computed(() => {
	const classes = [`p-${props.padding}`, `${props.transparent ? 'bg-transparent' : 'bg-white dark:bg-base'}`]
	return classes.join(' ')
})

const glowRadius = computed(() => `${props.radius}rem`)
</script>

<template>
	<div :class="parentClass">
		<div :class="childClass">
			<slot />
		</div>
	</div>
</template>

<style scoped>
.card {
    @apply
    relative
    flex flex-col justify-center items-center;
    --radius: v-bind(glowRadius);
}

.card > div {
    @apply
    flex flex-col justify-center items-center
    m-px
    w-[calc(100%-2px)]
    text-xs;
    border-radius: inherit;
    z-index: 10;
}
</style>
