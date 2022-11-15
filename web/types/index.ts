export { }

declare global {
	interface Account {
		name: string
		accountNo?: string
		guardianAccountNo: string
		dateOfBirth: Date
		occupation: string
		bank: string
		monthlyIncome: number
		balance: number
	}

	interface Session {
		uuid: string
		isValidated: boolean
		isBioValidated: boolean
		isTampered: boolean
		hasDistress: boolean
		isFailure: boolean
		isEmergency: boolean
		appScore: number
		overallScore: number
		transactionType: string
		timeCreated: Date
	}
}
