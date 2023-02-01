<script setup lang="ts">
withDefaults(defineProps<{
	to?: string
	color?: string
	animated?: boolean
}>(), {
	to: '/',
	color: '#e11d48',
	animated: true,
})
</script>

<template>
	<NuxtLink :to="to" class="link focus:outline-0 hover:scale-105 focus:scale-105 transition-all duration-200 ease-in-out" :class="{ animated }">
		<slot />
	</NuxtLink>
</template>

<style scoped>
.link.animated {
    @apply inline-block relative;
	color: v-bind(color);
}

.link.animated:after {
    @apply content-default absolute w-full scale-0 h-0.5 bottom-0 left-0 bg-inherit origin-bottom-right transition-transform duration-300 ease-out;
	background-color: v-bind(color);
}

.link.animated:hover:after {
    @apply scale-100 origin-bottom-left
}

.link.animated:focus:after {
    @apply scale-100 origin-bottom-left
}
</style>
