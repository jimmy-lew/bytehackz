<script setup lang="ts">
const path = usePath()
const pathSegments = computed(() => getPathSegments(path.value))
const title = computed(() => `${startingWithCapital(pathSegments.value[pathSegments.value.length - 1])} Logs`)

const hasFilters = computed(() => !!useSlots().filters)

const tabs = ['/dashboard/logs/transactions', '/dashboard/logs/sessions', '/dashboard/logs/atms']
</script>

<template>
	<SectionLogs :title="title" :tabs="tabs">
		<template v-if="hasFilters" #filters>
			<slot name="filters" />
		</template>
		<template #default>
			<slot />
		</template>
	</SectionLogs>
</template>

<style scoped>

</style>
