<script setup lang="ts">
const transactions = useTransactions()

const {
	transactions: transactionsArray,
	flagged,
	total,
} = toRefs(transactions.value)
</script>

<template>
	<SectionLogs title="Transaction Logs" />
</template>

<style scoped>

</style>
