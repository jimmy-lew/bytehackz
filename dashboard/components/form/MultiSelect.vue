<script setup lang="ts">
import type { Lyra } from '@lyrasearch/lyra'

const props = withDefaults(defineProps<{
	transformer: (...args: any[]) => any[]
	title: string
	db: Lyra<Schema>
	data: any[]
	initialSelection?: any[]
	error?: string
	placeholder?: string
	hasSearch?: boolean
	initialAllSelected?: boolean
	isCollapsed?: boolean
}>(), {
	isCollapsed: false,
	initialAllSelected: false,
})

const emits = defineEmits(['optionsToggled', 'optionSelected'])

const currentSelection = ref<any[]>(props.initialAllSelected ? [...props.data] : props.initialSelection || [])

const handleSelect = (selection: any) => {
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
		:has-search="hasSearch"
		is-multiselect
		@options-toggled="(isToggled) => emits('optionsToggled', isToggled)"
		@option-selected="(selectionValue) => emits('optionSelected', selectionValue)"
	>
		<ul v-if="!isCollapsed" class="flex flex-wrap gap-2 ml-3">
			<li v-if="currentSelection.length <= 0">
				{{ placeholder ? placeholder : 'Empty' }}
			</li>
			<li v-for="selection in currentSelection" v-else :key="selection" class="p-1 bg-[#141418] text-white rounded w-fit text-xs border-[0.5px] border-white/20">
				<div class="flex items-center gap-1">
					<Icon v-if="!(selection.icon.split('_')[0] === 'color') && selection.icon" size="16" :name="selection.icon" />
					<span v-if="selection.icon.split('_')[0] === 'color' && selection.icon" class="w-2.5 h-2.5 rounded-full" :class="`bg-${selection.icon.split('_')[1]}`" />
					{{ transformer(selection) }}
				</div>
			</li>
		</ul>
		<div v-else class="flex items-center justify-end w-full gap-2">
			{{ title }}
			<div class="rounded-full border-[0.5px] border-white/20 px-3">
				{{ currentSelection.length }} / {{ data.length }}
			</div>
		</div>
	</FormSelect>
</template>
