import { defineStore } from 'pinia'

export const useTransactionStore = defineStore('transaction', () => {
	const transaction = ref<Transaction>({
		to: '',
		from: '',
		type: '',
		timeCreated: new Date(),
		amount: 0,
		id: '',
		sessionID: '',
	})

	const setTransaction = (currentTransaction: any) => transaction.value = currentTransaction
	const setTransactionTo = (accNo: string) => transaction.value.to = accNo
	const setTransactionFrom = (accNo: string) => transaction.value.from = accNo
	const setTransactionAmount = (amount: number) => transaction.value.amount = amount

	return {
		transaction,
		setTransaction,
		setTransactionFrom,
		setTransactionTo,
		setTransactionAmount,
	}
})
