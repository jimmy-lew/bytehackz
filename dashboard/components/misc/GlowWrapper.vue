<script setup lang="ts">
const target = ref<Nullable<HTMLDivElement>>(null)

useEventListener(target, 'mousemove', ({ clientX, clientY }: MouseEvent) => {
	const parent = target.value

	if (parent == null) return

	for (const card of parent.getElementsByClassName('glow') as HTMLCollectionOf<HTMLElement>) {
		const { left, top } = card.getBoundingClientRect()
		const [x, y] = [clientX - left, clientY - top]

		card.style.setProperty('--x', `${x}px`)
		card.style.setProperty('--y', `${y}px`)
	}
})

useEventListener(target, 'mouseleave', (e: MouseEvent) => {
	const parent = target.value

	if (parent == null) return

	for (const card of parent.getElementsByClassName('glow') as HTMLCollectionOf<HTMLElement>) {
		const [x, y] = [NaN, NaN]

		card.style.setProperty('--x', `${x}px`)
		card.style.setProperty('--y', `${y}px`)
	}
})
</script>

<template>
	<div ref="target">
		<slot />
	</div>
</template>
