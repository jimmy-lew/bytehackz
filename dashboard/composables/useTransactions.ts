export default () => useState<{
	transactions: Transaction[]
	total: number
	flagged: number
}>('transactions', () => {
	return {
		transactions: [],
		total: 0,
		flagged: 0,
	}
})
