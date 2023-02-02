<script setup lang="ts">
import type { Lyra } from '@lyrasearch/lyra/dist/types'
const {
	handlers,
} = defineProps<{
	dbs: Record<string, Lyra<Schema>>
	data: Record<string, any[]>
	icons: Record<string, string>
	handlers: Record<string, (...args: any[]) => any>
}>()
const emits = defineEmits(['close'])

// #region Search
const searchResults = ref<Record<string, any[]>>({})
const handleRepopulate = (newResults: Record<string, any[]>) => searchResults.value = newResults
// #endregion

// #region Selection & Commands
const commandInputs = ref<any[]>([])
const currentCommand = ref<Nullable<InstanceType<typeof Command>>>(null)

// #region Handlers
const handleClick = async (dataKey: string, data: any) => {
	const { searchOptions: { type }, inputOptions } = data
	const isCommand = type === 'command'
	const requiresInput = !!inputOptions
	if (isCommand) currentCommand.value = data
	if (!requiresInput) return await handlers[`${dataKey}_handler`](data)
	Object.entries(inputOptions).forEach(([key, value]) => {
		commandInputs.value.push({ key, value })
	})
}
const handleInputChange = (key: string, value: string) => {
	const index = commandInputs.value.findIndex(({ key: _key }) => _key === key)
	commandInputs.value[index].value.data = value
}
// #endregion

const selectByIndex = (index: number) => {
	const [[key], [value]] = [Object.keys(searchResults.value), Object.values(searchResults.value)]
	if (value) handleClick(key, value[index])
}
const selectNearest = () => selectByIndex(0)
const { enter } = useMagicKeys({
	passive: false,
	onEventFired(e) {
		const { type, key } = e
		const isWatchedKey = ['Enter'].map(_key => _key === key).some(_key => Boolean(_key))
		if (isWatchedKey && type === 'keydown') e.preventDefault()
	},
})
whenever(enter, async () => {
	const { id } = useActiveElement().value || { id: '' }
	if (id && currentCommand.value == null) return selectByIndex(Number(id.split('-')[1]))
	if (commandInputs.value.length === 0) return selectNearest()
	await handlers.commands_handler(currentCommand.value)
	currentCommand.value = null
})
// #endregion
</script>

<!-- eslint-disable vue/no-use-v-if-with-v-for -->
<template>
	<ModalBase @close="() => emits('close')">
		<div class="flex items-center rounded-t py-4 px-6 border-b-[0.5px] border-white/20">
			<Search :dbs="dbs" :data="data" @repopulate="handleRepopulate">
				<template #input>
					<CommandInput v-for="{ key, value: { focus } } in commandInputs" v-if="commandInputs.length > 0" :key="key" :label="key" :has-focus="focus" @change="(change: any) => handleInputChange(key, change)" />
				</template>
			</Search>
		</div>
		<div class="pt-2">
			<div class="flex flex-col items-center pt-0 max-h-96 overflow-y-auto border-b-[0.5px] border-white/20">
				<SearchSection
					v-for="[key, value] in Object.entries(searchResults)"
					v-if="Object.values(searchResults).some(dataHit => dataHit.length > 0)"
					:key="key"
					:title="key"
				>
					<SearchItem
						v-for="(searchData, index) in value"
						v-if="key.length > 0"
						:id="`si-${index}`"
						:key="`si-${index}`"
						:data="searchData"
						:data-icon="icons[`${key}_icon`]"
						:data-key="key.slice(0, key.length - 1)"
						@click="handleClick(key, searchData)"
					/>
				</SearchSection>
				<div v-else class="py-10 text-gray-400">
					No Results...
				</div>
			</div>
			<div class="flex items-center gap-1 p-2 text-xs">
				<Card class="transition-all duration-500 ease-in scale-75">
					<div class="flex items-center justify-center px-1 text-sm">
						Tab
					</div>
				</Card>
				&
				<div class="flex items-center">
					<Card class="transition-all duration-500 ease-in scale-75">
						<div class="flex items-center justify-center px-1 text-sm">
							Shift
						</div>
					</Card>
					+
					<Card class="transition-all duration-500 ease-in scale-75">
						<div class="flex items-center justify-center px-1 text-sm">
							Tab
						</div>
					</Card>
				</div>
				for navigation
			</div>
		</div>
	</ModalBase>
</template>

<style scoped>
::-webkit-scrollbar {
    @apply w-2 h-2 bg-transparent
}
::-webkit-scrollbar-track {
    background: rgb(39 39 42);
}
::-webkit-scrollbar-thumb {
    @apply rounded-full;
    background: rgb(63 63 70);
}
</style>
