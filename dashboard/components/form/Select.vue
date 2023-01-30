<script setup lang="ts">
import type { Lyra } from '@lyrasearch/lyra'

// #region Props & Emits
const props = defineProps<{
	transformer: (...args: any[]) => any[]
	handler: (...args: any[]) => void
	db: Lyra<Schema>
	data: any[]
	currentSelection: string[]
	error?: string
	isMultiselect?: boolean
	hasSearch?: boolean
}>()

const emits = defineEmits<{
	(e: 'optionsToggled', isToggled: boolean): void
	(e: 'optionSelected', selectionValue: string | string[]): void
}>()

const {
	db: selects_db,
	data: selects,
	handler,
	isMultiselect,
} = toRefs(props)
// #endregion

// #region Refs
const isOptionsActive = ref(false)
const wasToggleCalled = ref(false)
const options = ref<HTMLDivElement | null>(null)
const trigger = ref<HTMLDivElement | null>(null)
const input = ref<HTMLInputElement | null>(null)

const searchHits = ref<any[]>([])
// #endregion

// #region Handlers
const toggleOptions = () => {
	isOptionsActive.value = !isOptionsActive.value
	wasToggleCalled.value = true
	emits('optionsToggled', isOptionsActive.value)
}

const handleTriggerFocus = (isFocused: boolean) => {
	if (wasToggleCalled.value) return wasToggleCalled.value = false
	if (isFocused && !isOptionsActive.value) return toggleOptions()
}

const handleEscape = () => {
	if (!isOptionsActive.value) return
	isOptionsActive.value = false
	emits('optionsToggled', false)
}

const handleSelect = (selection: string) => {
	handler.value(selection)
	if (!isMultiselect?.value) handleEscape()
}
// #endregion

// #region Search
const handleRepopulate = (hits: any[]) => searchHits.value = hits
// #endregion

// #region Interactivity
const { escape } = useMagicKeys()

useFocus(input, { initialValue: true })
const { focused: triggerFocused } = useFocus(trigger)
watch(triggerFocused, handleTriggerFocus)
whenever(escape, handleEscape)
onClickOutside(options, handleEscape)

const unmount = useEventListener('focusin', () => !options.value?.contains(document.activeElement) && handleEscape())

onBeforeUnmount(unmount)
// #endregion
</script>

<template>
	<div ref="options" class="relative w-full">
		<div ref="trigger" tabindex="0" class="text-gray-400 w-full rounded focus:bg-[#18181b] hover:bg-[#18181b] pl-0 sm:pl-1 p-1" :class="error ? 'error' : ''">
			<slot />
		</div>
		<span v-if="error" class="absolute top-1/2 right-0 -translate-y-1/2 text-xs px-1 text-error">
			{{ error }}
		</span>
		<div v-if="isOptionsActive" class="absolute top-0 z-20 w-full rounded bg-[#0a0a06] border-[0.5px] border-white/20 scale-105 animate-expand">
			<div v-if="hasSearch" class="flex items-center px-4 py-2 border-b-[0.5px] border-white/20">
				<Search :dbs="{ selects_db }" :data="{ selects }" @repopulate="({ selects }) => handleRepopulate(selects)" />
			</div>
			<ul v-if="searchHits.length <= 0" class="p-1 text-sm">
				<FormSelectOption
					v-for="option in transformer(data)"
					:key="option"
					:value="option"
					:is-option-selected="currentSelection.includes(option)"
					:is-multiselect="isMultiselect"
					@option-selected="handleSelect"
				/>
			</ul>
			<ul v-else class="p-1 text-sm">
				<FormSelectOption
					v-for="searchOption in transformer(searchHits)"
					:key="searchOption"
					:value="searchOption"
					:is-option-selected="currentSelection.includes(searchOption)"
					:is-multiselect="isMultiselect"
					@option-selected="handleSelect"
				/>
			</ul>
		</div>
	</div>
</template>

<style scoped>
.error {
    @apply outline-[0.5px] outline outline-error text-error text-xs sm:text-sm;
}
</style>
