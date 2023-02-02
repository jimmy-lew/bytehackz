<script setup lang="ts">
const props = defineProps<{
	label: string
	hasFocus: boolean
}>()
const emits = defineEmits(['change'])
const {
	hasFocus,
} = toRefs(props)
const input = ref<Nullable<HTMLElement>>(null)
const inputValue = ref('')
useFocus(input, { initialValue: hasFocus.value })
</script>

<template>
	<div class="card glow">
		<div class="relative flex">
			<span class="rounded-l px-2" contenteditable="false">
				{{ label }}:
			</span>
			<input ref="input" v-model="inputValue" :size="inputValue.length + 1" class="pl-2 -pr-4  bg-[#232325] h-6 rounded-r flex items-center focus:outline-0" @keyup="() => emits('change', inputValue)">
		</div>
	</div>
</template>

<style scoped>
.card {
    @apply
    relative
    flex flex-col justify-center items-center
    rounded
    bg-[#18181b];
    --radius: 6rem;
}
.card > div {
    @apply
    flex items-center
    m-px
    h-full
    text-xs
    bg-[#0c0c0c];
    border-radius: inherit;
    z-index: 1000;
}
</style>
