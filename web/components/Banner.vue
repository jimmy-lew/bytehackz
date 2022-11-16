<script setup>
const isOpen = ref(true)

const close = () => {
	isOpen.value = false
}
</script>

<template>
	<div v-if="isOpen" class="relative alert alert-warning shadow-lg rounded-md mb-4 text-base-content">
		<button v-if="!noCloseButton && !forceOpen" class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2" @click="close">
			✕
		</button>
		<slot />
	</div>
</template>
