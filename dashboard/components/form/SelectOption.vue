<script setup lang="ts">
const props = defineProps<{
	isMultiselect?: boolean
	checked?: boolean
	isOptionSelected: boolean
	value: string
	dataValue: any
	dataIcon?: string
}>()

const emits = defineEmits(['optionSelected'])

const option = ref<Nullable<HTMLElement>>(null)

const toggleOptionSelection = () => emits('optionSelected', props.dataValue)

const isColor = computed(() => props.dataIcon?.split('_')[0] === 'color')

const { focused } = useFocus(option)
const { enter } = useMagicKeys()

whenever(enter, () => {
	if (focused.value) toggleOptionSelection()
})
</script>

<template>
	<li ref="option" class="rounded focus:scale-105 focus:bg-[#e5e7eb] dark:focus:bg-[#18181b] transition-all ease-in-out duration-300" tabindex="0" @click="toggleOptionSelection">
		<div class="flex items-center gap-2 py-2 px-4">
			<Icon v-if="isMultiselect && !checked" size="16" :name="isOptionSelected ? 'material-symbols:check-box' : 'material-symbols:check-box-outline-blank'" />
			<div class="inline-flex items-center gap-1">
				<Icon v-if="!isColor && dataIcon" size="16" :name="dataIcon" />
				<span v-if="isColor && dataIcon" class="w-2.5 h-2.5 rounded-full" :class="`bg-${dataIcon.split('_')[1]}`" />
				{{ value }}
			</div>
			<div class="inline-flex justify-end w-full">
				<Icon v-if="isMultiselect && checked" size="18" :name="isOptionSelected ? 'bi:check' : ''" />
			</div>
		</div>
	</li>
</template>

<style scoped>
li:hover {
    @apply bg-[#e5e7eb] dark:bg-[#18181b] scale-105 dark:outline dark:outline-1
}
</style>
