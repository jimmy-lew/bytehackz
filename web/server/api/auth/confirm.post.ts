import { db } from '../lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const { isFailure, isEmergency, appScore } = body

	const atmID = '000001'
	const collection = `atms/${atmID}/sessions`

	const atmSessionsSnapshot = await db
		.collection(collection)
		.orderBy('timeCreated')
		.limitToLast(1)
		.get()

	const session = atmSessionsSnapshot.docs.map((doc) => {
		db.collection(collection).doc(doc.id).update({
			isFailure,
			isEmergency,
			appScore,
		})

		return {
			uuid: doc.id,
			...doc.data(),
		}
	})

	return session
})
