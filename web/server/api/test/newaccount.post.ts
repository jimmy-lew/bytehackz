import { db } from '../lib/firebase'

export default defineEventHandler(async () => {
	const uuid = 'f33f888e-4a0f-4645-9ce5-baff42a5c7dc'

	const user: User = {
		bank: 'OCBC',
		name: 'Scammer',
		guardianUUID: '',
		dateOfBirth: new Date('22 August 2004'),
		occupation: 'Scammer',
		monthlyIncome: 3000,
		accounts: [
			'103-000000-000',
		],
	}

	// const docID = '102-000000-000'
	await db.collection('users').doc(uuid).set(user)

	return user
})
