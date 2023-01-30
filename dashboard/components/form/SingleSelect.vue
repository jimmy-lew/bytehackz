<script setup lang="ts">
import type { Lyra } from '@lyrasearch/lyra'

const props = defineProps<{
	transformer: (...args: any[]) => any[]
	db: Lyra<Schema>
	data: any[]
	error?: string
	placeholder?: string
	hasSearch?: boolean
}>()

const emits = defineEmits(['optionsToggled', 'optionSelected'])

const currentSelection = ref<string[]>([])

const handleSelect = (selection: any) => {
	currentSelection.value[0] = selection
	emits('optionSelected', currentSelection.value)
}
</script>

<template>
	<FormSelect
		v-bind="props"
		:current-selection="currentSelection"
		:handler="handleSelect"
		:has-search="hasSearch"
		@options-toggled="(isToggled) => emits('optionsToggled', isToggled)"
		@option-selected="(selectionValue) => emits('optionSelected', selectionValue)"
	>
		<div class="px-2">
			<p v-if="currentSelection.length > 0" class="text-black dark:text-white">
				{{ transformer(currentSelection[0]) }}
			</p>
			<p v-else>
				{{ placeholder ? placeholder : 'Empty' }}
			</p>
		</div>
	</FormSelect>
</template>
