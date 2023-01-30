<script setup lang="ts">
const props = withDefaults(defineProps<{
	link: string
}>(), {
	link: '/',
})

const path = usePath()

const isActiveRoute = computed(() => path.value === props.link)
</script>

<template>
	<div class="relative inline-flex flex-wrap justify-content text-sm px-4 pt-2 pb-4 border-b transition-all duration-300 ease-in" :class="{ 'border-rose-600': isActiveRoute, 'font-bold': isActiveRoute, 'border-transparent': !isActiveRoute }">
		<NuxtLink :to="link">
			<slot />
		</NuxtLink>
	</div>
</template>

<style scoped>

</style>
