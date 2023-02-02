<script setup lang="ts">
import type { Lyra } from '@lyrasearch/lyra'
const props = defineProps<{
	dbs: Record<string, Lyra<Schema>>
	data: Record<string, any[]>
	icons: Record<string, string>
	handlers: Record<string, (...args: any[]) => any>
}>()
const emits = defineEmits(['close'])

const sidebar = ref<Nullable<HTMLElement>>(null)
onClickOutside(sidebar, () => emits('close'))
</script>

<template>
	<div class="fixed top-0 right-0 h-full w-full max-w-md z-[2000] p-4">
		<div
			ref="sidebar"
			class="
            sidebar
            relative
            flex flex-col
            h-full
            rounded-lg
            bg-[#f8f8f8] dark:bg-[#0c0c0c]
            border-[0.5px] border-[#e5e7eb] dark:border-white/20"
		>
			<div class="flex items-center justify-between pt-6 pb-4 px-5">
				Help Center
				<div class="p-1 rounded-full hover:bg-[#e5e7eb] dark:hover:bg-[#18181b]">
					<Icon name="ion:close" size="24" @click="emits('close')" />
				</div>
			</div>
			<div class="flex items-center px-5 py-2">
				<div class="flex items-center rounded-md border border-[#e5e7eb] dark:border-white/20 w-full px-2 py-1">
					<Search :dbs="dbs" :data="data" @repopulate="() => {}" />
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>
.sidebar {
    box-shadow: 0 16px 70px rgb(0 0 0 / 20%);
}
</style>
