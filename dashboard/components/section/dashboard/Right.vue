<script setup lang="ts">
const transactions = useTransactions()

const {
	transactions: transactionsArray,
	flagged,
	total,
} = toRefs(transactions.value)

const averageTransactionAmount = computed(() => {
	const total = transactionsArray.value.reduce((acc, { amount }) => acc + amount, 0)
	return total / transactionsArray.value.length
})

const highestTransactionAmount = computed(() => {
	const highest = transactionsArray.value.reduce((acc, { amount }) => Math.max(acc, amount), 0)
	return highest
})
</script>

<template>
	<div class="flex-1">
		<div class="space-y-6 mt-12">
			<div class="grid grid-flow-col gap-1">
				<Stats :radius="16">
					<StatsItem icon="heroicons:scale" title="Average amount" :value="averageTransactionAmount" />
					<StatsItem icon="heroicons:arrow-trending-up" title="Highest amount" :value="highestTransactionAmount" />
				</Stats>
			</div>
			<div class="space-y-4">
				<div>
					<StatsLinearProgress title="Flagged over total" :value="flagged" :max="total" />
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>

</style>
