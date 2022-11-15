import { defineStore } from 'pinia'

export const useAccountStore = defineStore('account', () => {
	const name = ref('Jimmy')
	const transferTo = ref('')
	const setTransferTo = (accNo: string) => transferTo.value = accNo
	const transferFrom = ref('')
	const setTransferFrom = (accNo: string) => transferFrom.value = accNo
	const transactionAmount = ref(0)
	const setTransactionAmount = (amount: number) => transactionAmount.value = amount

	return { name, transferFrom, transferTo, setTransferFrom, setTransferTo, transactionAmount, setTransactionAmount }
})
