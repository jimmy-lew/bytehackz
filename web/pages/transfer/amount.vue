<script setup lang="ts">
const keyStore = useKeyInputStore()
const transactionStore = useTransactionStore()
const { setTransactionAmount } = transactionStore

const {
	input,
} = toRefs(keyStore)

const { clearInput } = keyStore

const handleClick = async () => {
	setTransactionAmount(parseInt(input.value))
	clearInput()
	await navigateTo('/transfer/confirm')
}
</script>

<template>
	<NuxtLayout name="transfer">
		<template #left>
			<div class="flex flex-col items-center h-full">
				Enter amount
				<div class="mt-4 text-4xl">
					{{ input }}
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
