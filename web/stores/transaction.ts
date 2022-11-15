import { defineStore } from 'pinia'

export const useTransactionStore = defineStore('transaction', () => {
	const transactionTo = ref('')
	const settransactionTo = (accNo: string) => transactionTo.value = accNo
	const transactionFrom = ref('')
	const settransactionFrom = (accNo: string) => transactionFrom.value = accNo
	const transactionAmount = ref(0)
	const setTransactionAmount = (amount: number) => transactionAmount.value = amount

	return { transactionFrom, transactionTo, settransactionFrom, settransactionTo, transactionAmount, setTransactionAmount }
})
