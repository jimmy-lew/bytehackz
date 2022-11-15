import { defineStore } from 'pinia'

export const useTransactionStore = defineStore('transaction', () => {
	const transactionID = ref('')
	const transactionTo = ref('')
	const transactionFrom = ref('')
	const transactionAmount = ref(0)

	const setTransactionID = (id: string) => transactionID.value = id
	const setTransactionTo = (accNo: string) => transactionTo.value = accNo
	const setTransactionFrom = (accNo: string) => transactionFrom.value = accNo
	const setTransactionAmount = (amount: number) => transactionAmount.value = amount

	return {
		transactionID,
		transactionTo,
		transactionFrom,
		transactionAmount,
		setTransactionID,
		setTransactionFrom,
		setTransactionTo,
		setTransactionAmount,
	}
})
