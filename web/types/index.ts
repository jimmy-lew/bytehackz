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
		accountCreationDate: Date
		monthlyIncome: number
	}

	interface Session {
		uuid: string
		isValidated: boolean
		isBioValidated: boolean
		isTampered: boolean
		isFailure: boolean
		isEmergency: boolean
		fearScore: number
		appScore: number
		overallScore: number
		transactionID: string
		timeCreated: Date
	}

	interface Transaction {
		id: string
		atmID: string
		to: string
		from: string
		type?: string
		sessionID: string
		timeCreated: Date
		amount: number
	}

	type Nullable<T> = T | null
}
