<script setup lang="ts">
const keyStore = useKeyInputStore()
const accStore = useAccountStore()
const { transferFrom, setTransferTo } = accStore

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

const handleClick = () => {
	if (input.value.length < 10)
		return

	setTransferTo(accountNo.value)
	navigateTo('/transfer/amount')
}
</script>

<template>
	<NuxtLayout name="transfer">
		<template #left>
			<div class="flex flex-col items-center h-full">
				Enter account you are transferring to
				<div class="mt-4 text-4xl">
					{{ accountNo }}
				</div>
				<button class="mt-auto btn relative w-1/2 glass-outline rounded-md" @click="handleClick">
					Confirm
				</button>
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
