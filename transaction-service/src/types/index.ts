import type { Timestamp } from 'firebase/firestore'

export type Nullable<T> = T | null

export interface Account {
    uuid: string
    balance: number
}

export interface User {
    name: string
    accounts: string[]
    guardianUUID: string
    dateOfBirth: Date
    occupation: string
    bank: string
    accountCreationDate: Date
    monthlyIncome: number
}

export interface Session {
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
    timeCreated: Timestamp
    timeCompleted?: Timestamp
}

export type TransactionType = 'Transfer' | 'Withdrawal' | 'Deposit'

export interface Transaction {
    id: string
    atmID: string
    to: string
    from: string
    type?: TransactionType
    sessionID: string
    timeCreated: Timestamp
    timeCompleted?: Timestamp
    amount: number
}