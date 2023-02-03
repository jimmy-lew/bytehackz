<script setup lang="ts">
defineProps<{
	items: {
		label: string
		action?: (...args: any[]) => any
		hasTopBorder?: boolean
	}[]
}>()

const isMenuActive = ref(false)
const toggleMenu = () => isMenuActive.value = !isMenuActive.value
const menu = ref<Nullable<HTMLElement>>(null)
const trigger = ref<Nullable<HTMLElement>>(null)

const { escape, enter } = useMagicKeys()
const { focused } = useFocus(trigger)

onClickOutside(menu, () => isMenuActive.value = false)
whenever(escape, () => isMenuActive.value = false)
whenever(enter, () => focused.value && toggleMenu())
</script>

<template>
	<div class="relative inline-block">
		<div ref="trigger" tabindex="0" class="focus:outline-0 focus:scale-110 hover:scale-110 transition-all duration-300 ease-in-out" @click="toggleMenu">
			<slot name="trigger" />
		</div>
		<Transition name="fade">
			<ul v-if="isMenuActive" ref="menu" class="absolute z-40 right-0 flex flex-col mt-5 rounded-md bg-white dark:bg-[#0c0c0c] shadow-lg origin-top-right ring-1 ring-[#e5e7eb] dark:ring-white/20 min-w-[12rem]">
				<LazyDropdownItem v-for="item in items" :key="item.label" v-bind="item" @action="toggleMenu" />
				<slot name="items" />
			</ul>
		</Transition>
	</div>
</template>

<style scoped>
</style>
