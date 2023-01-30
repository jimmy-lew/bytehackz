<script setup lang="ts">
withDefaults(defineProps<{
	isVertical?: boolean
	radius?: number
	round?: RoundTypes
	noGlow?: boolean
}>(), {
	isVertical: false,
	round: 'md',
	radius: 6,
	noGlow: false,
})
</script>

<template>
	<Card :padding="0" :no-glow="noGlow" :round="round" :radius="radius" transparent>
		<div class="stats flex w-full bg-transparent">
			<slot />
		</div>
	</Card>
</template>

<style>
.stats {
	border-radius: inherit;
}

.stats > .stat:first-child {
	border-top-left-radius: inherit;
	border-bottom-left-radius: inherit;
}

.stats > .stat:last-child {
	border-top-right-radius: inherit;
	border-bottom-right-radius: inherit;
}

.stats > .stat:not(:first-child) {
    @apply ml-px
}
</style>
