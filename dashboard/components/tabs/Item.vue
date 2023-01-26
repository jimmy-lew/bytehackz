<script setup lang="ts">
const props = withDefaults(defineProps<{
	link: string
}>(), {
	link: '/',
})

const { path } = useRoute()

const isActiveRoute = computed(() => path === props.link)
</script>

<template>
	<div class="relative inline-flex flex-wrap justify-content text-sm px-4 pt-2 pb-4 border-rose-600" :class="{ 'border-b': isActiveRoute, 'font-bold': isActiveRoute }">
		<NuxtLink :to="link">
			<slot />
		</NuxtLink>
	</div>
</template>

<style scoped>

</style>
