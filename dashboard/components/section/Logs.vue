<script setup lang="ts">
withDefaults(defineProps<{
	title: string
	tabs: string[]
}>(), {
	title: 'Logs',
	tabs: () => [],
})

const hasFilters = computed(() => !!useSlots().filters)
</script>

<template>
	<div class="sticky -top-20 z-30 w-full border-b dark:border-white/20 bg-white dark:bg-[#0c0c0c]">
		<div class="max-w-7xl mx-auto -mb-px px-6 sm:px-12 lg:px-16 xl:px-0">
			<h1 class="text-3xl font-bold" :class="hasFilters || tabs.length > 0 ? 'py-6' : 'py-12'">
				{{ title }}
			</h1>
			<div v-if="hasFilters" class="flex gap-x-4 mt-2 mb-4">
				<slot name="filters" />
			</div>
			<Tabs v-if="tabs.length > 0">
				<TabsItem v-for="link in tabs" :key="link" :link="link" is-bordered />
				<TabsItem is-bordered is-filler />
			</Tabs>
		</div>
	</div>
	<MiscGlowWrapper class="w-full min-h-[calc(100vh-305px)] bg-[#f8f8f8] dark:bg-[#121212]">
		<div class="mx-auto max-w-7xl h-full">
			<div class="py-12">
				<Transition name="fade">
					<slot />
				</Transition>
			</div>
		</div>
	</MiscGlowWrapper>
</template>

<style scoped>
</style>
