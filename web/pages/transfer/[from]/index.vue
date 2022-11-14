<script setup lang="ts">
const keyStore = useKeyInputStore()

const {
	input,
} = toRefs(keyStore)

const accountNo = computed(() => {
	let accNo = input.value

	if (input.value.length >= 4)
		accNo = `${accNo.slice(0, 3)}-${accNo.slice(3)}`
	if (input.value.length > 9)
		accNo = `${accNo.slice(0, 10)}-${accNo.slice(10)}`
	return accNo
})
</script>

<template>
	<NuxtLayout name="transfer">
		<template #left>
			<div class="flex flex-col items-center">
				<div class="text-4xl">
					{{ accountNo }}
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
