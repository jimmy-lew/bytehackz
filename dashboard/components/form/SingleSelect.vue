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
	currentSelection.value[0] = selection
	emits('optionSelected', currentSelection.value)
}
</script>

<template>
	<FormSelect
		v-bind="props"
		:current-selection="currentSelection"
		:handler="handleSelect"
		@options-toggled="(isToggled) => emits('optionsToggled', isToggled)"
		@option-selected="(selectionValue) => emits('optionSelected', selectionValue)"
	>
		<p v-if="currentSelection.length > 0" class="text-white">
			{{ currentSelection[0] }}
		</p>
		<p v-else>
			{{ placeholder ? placeholder : 'Empty' }}
		</p>
	</FormSelect>
</template>
