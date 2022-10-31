<script setup lang="ts">
const { title, href, padding } = defineProps<{
	title: string
	href: string
	padding?: string
}>()
</script>

<template>
	<li class="card relative rounded-2xl shadow-md transition-all ease-astro duration-300 hover:scale-105 focus:scale-105">
		<a :href="href" class="relative card-body glass-outline ease-astro rounded-2xl">
			<div class="my-auto flex flex-col items-center justify-center">
				<slot />
				<p class="font-medium">{{ title }}</p>
			</div>
		</a>
	</li>
</template>

<style scoped>
html[data-theme="light"] .card:hover .glass-outline::before {
    background: linear-gradient(to bottom left, rgba(217, 104, 164, 0.6),rgba(216, 144, 130, 0.2) 120%);
}
</style>
