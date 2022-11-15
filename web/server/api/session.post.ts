import { randomUUID } from 'crypto'
import { db } from './lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const { accountNo } = body

	const atmID = '000001'

	if (!accountNo) {
		return {
			error: 'missing account number',
		}
	}

	// {randomUUID}-{currentTime}
	const docID = `${randomUUID()}-${new Date().toLocaleTimeString('it-IT').replace(/:/g, '')}`
	const session = await db.collection(`atm/${atmID}/sessions`).doc(docID).set({
		accountNo,
		isValidated: true,
		isBioValidated: false,
		isTampered: false,
		hasDistress: false,
		isFailure: false,
		isEmergency: false,
		appScore: 0,
		overallScore: 0,
		timeCreated: new Date(),
	})

	return session
})
