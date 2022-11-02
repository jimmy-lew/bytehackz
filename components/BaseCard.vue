<script setup lang="ts">
const props = withDefaults(defineProps<{
	round?: Sizing
	size?: string
}>(), {
	round: '2xl',
	size: '0',
})

type Sizing = 'xs' | 'sm' | 'md' | 'lg' | 'xl' | '2xl'

const {
	round,
	size,
} = toRefs(props)

const cardClassNames = computed(() => `card card-compact relative glass-outline rounded-${round.value} p-${size.value} shadow-md transition-all ease-astro duration-300 hover:scale-105`)
const cardBodyClassNames = computed(() => `card-body ease-astro rounded-${round.value}`)
</script>

<template>
	<div :class="cardClassNames">
		<div :class="cardBodyClassNames">
			<slot />
		</div>
	</div>
</template>

<style scoped>

</style>
