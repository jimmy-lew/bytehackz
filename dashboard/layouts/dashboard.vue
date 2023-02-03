<script setup lang="ts">
import type { Ref } from 'vue'

// #region Toggles
const dblShift = ref(false)
const isModalActive = ref(false)
const isSidebarActive = ref(false)

const modalTrigger = ref<HTMLElement>() as Ref<HTMLElement>
const documentationTrigger = ref<HTMLElement>() as Ref<HTMLElement>

const toggleModal = () => {
	isModalActive.value = !isModalActive.value
	console.log('Toggling modal...')
}

const toggleSidebar = () => {
	isSidebarActive.value = !isSidebarActive.value
	console.log('Toggling sidebar...')
}
// #endregion

// #region Magic Keys
const { shift, escape, enter, shift_slash } = useMagicKeys()

const { focused: modalTriggerFocused } = useFocus(modalTrigger)
const { focused: documentationTriggerFocused } = useFocus(documentationTrigger)

whenever(shift, () => {
	if (dblShift.value) return toggleModal()
	dblShift.value = true
	setTimeout(() => dblShift.value = false, 500)
})

whenever(shift_slash, toggleSidebar)

whenever(escape, () => {
	if (isModalActive.value) isModalActive.value = false
	if (isSidebarActive.value) isSidebarActive.value = false
})

whenever(enter, () => {
	if (modalTriggerFocused.value) return toggleModal()
	if (documentationTriggerFocused.value) return toggleSidebar()
})
// #endregion
</script>

<template>
	<NavDashboard />
	<main class="mx-auto w-full flex-1">
		<slot />
	</main>
	<Transition name="right" appear>
		<DashboardSidebar v-if="isSidebarActive" :dbs="{}" :data="{}" :handlers="{}" :icons="{}" @close="toggleSidebar" />
	</Transition>
	<Transition name="fade" appear>
		<DashboardModal v-if="isModalActive" :dbs="{}" :data="{}" :handlers="{}" :icons="{}" @close="toggleModal" />
	</Transition>
	<div class="fixed bottom-0 right-0 flex flex-col gap-4 p-5">
		<Card ref="documentationTrigger" tabindex="0" class="transition-all duration-300 ease-in outline-none focus:scale-110 hover:scale-110" @click="toggleSidebar">
			<div class="flex items-center justify-center w-4 h-4">
				?
			</div>
		</Card>
		<Card ref="modalTrigger" tabindex="0" class="transition-all duration-300 ease-in outline-none focus:scale-110 hover:scale-110" @click="toggleModal">
			<div class="flex items-center justify-center w-4 h-4">
				/
			</div>
		</Card>
	</div>
</template>

<style global>
</style>
