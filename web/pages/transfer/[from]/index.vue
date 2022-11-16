<script setup lang="ts">
const keyStore = useKeyInputStore()

const {
	input,
} = toRefs(keyStore)
</script>

<template>
	<NuxtLayout name="transfer">
		<template #left>
			<div class="flex flex-col items-center">
				<div class="text-4xl">
					{{ input }}
				</div>
			</div>
		</template>
		<template #right>
			<div class="flex items-center justify-center w-full">
				<TheVirtualKeyBoard />
			</div>
		</template>
	</NuxtLayout>
</template>

<style scoped>

</style>
