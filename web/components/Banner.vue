<script setup>
const isOpen = ref(true)

const close = () => {
	isOpen.value = false
}
</script>

<template>
	<div v-if="isOpen" class="relative alert alert-warning shadow-lg rounded-md mb-4 text-base-content">
		<div class="w-1/2">
			<slot />
		</div>
		<div class="w-1/2 inline-flex justify-end">
			<button class="btn btn-sm btn-circle btn-ghost" @click="close">
				✕
			</button>
		</div>
	</div>
</template>
