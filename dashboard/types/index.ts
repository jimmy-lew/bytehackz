/* eslint-disable no-mixed-spaces-and-tabs */
import type { PropertiesSchema } from '@lyrasearch/lyra'
import type { Timestamp } from 'firebase/firestore'

export { }

declare global {
    type Nullable<T> = T | null

    type SizeTypes = 'none' | 'sm' | 'md' | 'lg' | 'xl' | '2xl' | '3xl' | 'full'
    type RoundTypes = SizeTypes

    interface Schema extends PropertiesSchema {
    	_id: 'number'
    }

    interface DateRangeItem {
    	_id: number
    	date: string
    	value: string
    }

    interface ChartData {
    	total: number
    	flagged: number
    }

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
    	timeCreated: Timestamp
    	amount: number
    }
}
