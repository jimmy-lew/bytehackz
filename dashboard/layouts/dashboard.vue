<script setup lang="ts">
import type { Ref } from 'vue'

const dblShift = ref(false)
const isModalActive = ref(false)

const modalTrigger = ref<HTMLElement>() as Ref<HTMLElement>
const documentationTrigger = ref<HTMLElement>() as Ref<HTMLElement>

const toggleModal = () => {
	isModalActive.value = !isModalActive.value
	console.log('Toggling modal...')
}

const { shift, escape, enter } = useMagicKeys({
	passive: false,
	onEventFired(e) {
		const { type, key } = e
		const isWatchedKey = ['shift', 'escape'].map(_key => _key === key).some(_key => Boolean(_key))
		if (isWatchedKey && type === 'keydown') e.preventDefault()
	},
})

const { focused: modalTriggerFocused } = useFocus(modalTrigger)
const { focused: documentationTriggerFocused } = useFocus(documentationTrigger)

whenever(escape, () => {
	if (!isModalActive.value) return
	isModalActive.value = false
})

whenever(shift, () => {
	if (dblShift.value) return toggleModal()
	dblShift.value = true
	setTimeout(() => dblShift.value = false, 500)
})

whenever(enter, () => {
	if (modalTriggerFocused.value) return toggleModal()
	if (documentationTriggerFocused.value) return console.log('Opening documentation...')
})
</script>

<template>
	<NavDashboard />
	<main class="mx-auto w-full flex-1">
		<slot />
	</main>
	<DashboardModal v-if="isModalActive" :dbs="{}" :data="{}" :handlers="{}" :icons="{}" @close="toggleModal" />
	<div class="fixed bottom-0 right-0 flex flex-col gap-4 p-4">
		<Card ref="documentationTrigger" tabindex="0" class="transition-all duration-300 ease-in focus:scale-110 hover:scale-110">
			<div class="flex items-center justify-center w-4 h-4">
				?
			</div>
		</Card>
		<Card ref="modalTrigger" tabindex="0" class="transition-all duration-300 ease-in focus:scale-110 hover:scale-110" @click="toggleModal">
			<div class="flex items-center justify-center w-4 h-4">
				/
			</div>
		</Card>
	</div>
</template>

<style scoped>

</style>
