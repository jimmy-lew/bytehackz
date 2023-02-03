<script setup lang="ts">
defineProps<{
	link: string
}>()
</script>

<template>
	<Transition appear>
		<li class="breadcrumb flex items-center mr-1">
			<NuxtLink :to="link">
				<slot />
			</NuxtLink>
		</li>
	</Transition>
</template>

<style scoped>
.v-enter-active,
.v-leave-active {
  transition: opacity 0.5s ease-in;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>
