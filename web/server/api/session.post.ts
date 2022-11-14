import { randomUUID } from 'crypto'
import { db } from './lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const { accountNo } = body

	const atmID = '000001'

	// {randomUUID}-{currentTime}
	const docID = `${randomUUID()}-${new Date().toLocaleTimeString('it-IT').replace(/:/g, '')}`
	const session = await db.collection(`atm/${atmID}/sessions`).doc(docID).set({
		accountNo,
		isValidated: false,
		isBioValidated: false,
		isTampered: false,
		hasDistress: false,
		timeCreated: new Date(),
	})

	return session
})
