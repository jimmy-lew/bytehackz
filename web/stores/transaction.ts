import { defineStore } from 'pinia'

export const useTransactionStore = defineStore('transaction', () => {
	const transactionTo = ref('')
	const setTransactionTo = (accNo: string) => transactionTo.value = accNo
	const transactionFrom = ref('')
	const setTransactionFrom = (accNo: string) => transactionFrom.value = accNo
	const transactionAmount = ref(0)
	const setTransactionAmount = (amount: number) => transactionAmount.value = amount

	return { transactionFrom, transactionTo, setTransactionFrom, setTransactionTo, transactionAmount, setTransactionAmount }
})
