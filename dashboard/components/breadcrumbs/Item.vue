<script setup lang="ts">
defineProps<{
	link: string
}>()
</script>

<template>
	<li class="breadcrumb flex items-center mr-1 font-medium">
		<NuxtLink :to="link">
			<slot />
		</NuxtLink>
	</li>
</template>

<style scoped>

</style>
