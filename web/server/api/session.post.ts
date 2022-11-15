import { randomUUID } from 'crypto'
import { db } from './lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const { uuid } = body

	const atmID = '000001'

	if (!uuid) {
		return {
			error: 'missing account number',
		}
	}

	const session: Session = {
		uuid,
		isValidated: true,
		isBioValidated: false,
		isTampered: false,
		hasDistress: false,
		isFailure: false,
		isEmergency: false,
		appScore: 0,
		overallScore: 0,
		transcationType: '',
		timeCreated: new Date(),
	}

	// {randomUUID}-{currentTime}
	const docID = `${randomUUID()}-${new Date().toLocaleTimeString('it-IT').replace(/:/g, '')}`
	await db.collection(`atm/${atmID}/sessions`).doc(docID).set(session)

	return session
})
