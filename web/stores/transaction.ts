import { defineStore } from 'pinia'

export const useTransactionStore = defineStore('transaction', () => {
	const transaction = ref<Transaction>(null)
	const transactionTo = ref('')
	const transactionFrom = ref('')
	const transactionAmount = ref(0)

	const setTransaction = (currentTransaction: any) => transaction.value = currentTransaction
	const setTransactionTo = (accNo: string) => transaction.value.to = accNo
	const setTransactionFrom = (accNo: string) => transaction.value.from = accNo
	const setTransactionAmount = (amount: number) => transaction.value.amount = amount

	return {
		transaction,
		transactionTo,
		transactionFrom,
		transactionAmount,
		setTransaction,
		setTransactionFrom,
		setTransactionTo,
		setTransactionAmount,
	}
})
