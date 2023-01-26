<script setup lang="ts">
import type { Lyra } from '@lyrasearch/lyra/dist/types'

const props = defineProps<{
	dbs: Record<string, Lyra<Schema>>
	data: Record<string, any[]>
}>()

const emits = defineEmits(['repopulate'])

const {
	dbs,
	data,
} = toRefs(props)

const input = ref<Nullable<HTMLInputElement>>(null)

const search = ref('')
const searchResults = ref<Record<string, any[]>>(
	Object.fromEntries(
		Object.keys(dbs.value)
			.map(key => key.split('_')[0])
			.map(key => [key, []]),
	),
)

const handleInput = (e: KeyboardEvent) => {
	const { target } = e
	if (!(target instanceof HTMLDivElement)) return
	search.value = target.innerText
}

watch(search, (term) => {
	Object.entries(dbs.value).forEach(async ([dirtyKey, db]) => {
		const [key] = dirtyKey.split('_')

		const hits = await lyraSearch(db, data.value[key], term)

		searchResults.value[key] = (hits.length && !hits.some((data: any) => !data)) ? [...hits] : []
	})

	emits('repopulate', searchResults.value)
})

useFocus(input, { initialValue: true })
</script>

<template>
	<Icon name="line-md:search" class="-scale-x-100 mr-2" />
	<div
		ref="input"
		class="relative w-[calc(100%-24px)] bg-transparent focus:outline-0 flex flex-wrap gap-2"
		contenteditable="true"
		placeholder="Type to search..."
		@keydown="handleInput"
	>
		<slot name="input" />
	</div>
</template>

<style scoped>
[contenteditable][placeholder]:empty::before{
    @apply text-zinc-400/90 content-[attr(placeholder)];
}
</style>
