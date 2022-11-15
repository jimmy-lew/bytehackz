export { }

declare global {
	interface Account {
		uuid: string
		balance: number
	}

	interface User {
		name: string
		accounts: string[]
		guardianUUID: string
		dateOfBirth: Date
		occupation: string
		bank: string
		monthlyIncome: number
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
		transactionID: string
		timeCreated: Date
	}

	interface Transaction {
		id: string
		to: string
		from: string
		amount: number
	}
}
