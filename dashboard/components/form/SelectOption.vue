<script setup lang="ts">
const props = defineProps<{
	isMultiselect?: boolean
	isOptionSelected: boolean
	value: string
}>()

const emits = defineEmits(['optionSelected'])

const {
	value,
} = toRefs(props)

const option = ref<Nullable<HTMLElement>>(null)

const toggleOptionSelection = () => emits('optionSelected', value.value)

const { focused } = useFocus(option)
const { enter } = useMagicKeys()

whenever(enter, () => {
	if (focused.value) toggleOptionSelection()
})
</script>

<template>
	<li ref="option" class="rounded focus:scale-105 focus:bg-[#18181b] transition-all ease-in-out duration-300" tabindex="0" @click="toggleOptionSelection">
		<div class="flex items-center gap-2 py-2 px-4">
			<Icon v-if="isMultiselect" size="16" :name="isOptionSelected ? 'material-symbols:check-box' : 'material-symbols:check-box-outline-blank'" />
			{{ value }}
		</div>
	</li>
</template>

<style scoped>
li:hover {
    @apply bg-[#18181b] scale-105 outline outline-1
}
</style>
