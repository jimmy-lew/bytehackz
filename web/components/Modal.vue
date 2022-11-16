<script setup lang="ts">
import { vOnClickOutside } from '@vueuse/components'

const { noCloseButton, forceOpen } = withDefaults(defineProps<{
	noCloseButton?: boolean
	forceOpen?: boolean
}>(), {
	noCloseButton: false,
	forceOpen: false,
})

const isOpen = ref(true)

const close = () => {
	if (forceOpen)
		return
	isOpen.value = false
}

onKeyStroke('Escape', (e) => {
	close()
})
</script>

<template>
	<div v-if="isOpen" class="modal modal-open">
		<div v-on-click-outside="close" class="modal-box rounded-md relative bg-white w-fit">
			<button v-if="!noCloseButton && !forceOpen" class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2" @click="close">
				✕
			</button>
			<slot />
		</div>
	</div>
</template>
