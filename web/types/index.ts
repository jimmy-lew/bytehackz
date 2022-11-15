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
		accountNo: string
		isValidated: boolean
		isBioValidated: boolean
		isTampered: boolean
		hasDistress: boolean
		isFailure: boolean
		isEmergency: boolean
		appScore: number
		overallScore: number
		transcationType: string
		timeCreated: Date
	}
}
