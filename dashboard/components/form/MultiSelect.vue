<script setup lang="ts">
import type { Lyra } from '@lyrasearch/lyra'

const props = defineProps<{
	transformer: (...args: any[]) => any[]
	db: Lyra<Schema>
	data: any[]
	error?: string
	placeholder?: string
}>()

const emits = defineEmits(['optionsToggled', 'optionSelected'])

const currentSelection = ref<string[]>([])

const handleSelect = (selection: string) => {
	if (currentSelection.value.includes(selection)) {
		currentSelection.value.splice(currentSelection.value.indexOf(selection), 1)
		return
	}
	else {
		currentSelection.value.push(selection)
		currentSelection.value.sort()
	}
	emits('optionSelected', currentSelection.value)
}
</script>

<template>
	<FormSelect
		v-bind="props"
		:current-selection="currentSelection"
		:handler="handleSelect"
		is-multiselect
		@options-toggled="(isToggled) => emits('optionsToggled', isToggled)"
		@option-selected="(selectionValue) => emits('optionSelected', selectionValue)"
	>
		<ul class="flex flex-wrap gap-2">
			<li v-if="currentSelection.length <= 0">
				{{ placeholder ? placeholder : 'Empty' }}
			</li>
			<li v-for="selection in currentSelection" v-else :key="selection" class="p-1 bg-[#141418] text-white rounded w-fit text-xs border-[0.5px] border-white/20">
				{{ selection }}
			</li>
		</ul>
	</FormSelect>
</template>
