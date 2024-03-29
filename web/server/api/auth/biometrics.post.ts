import { db } from '../lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const atmID = '000001'
	const { auth, isEmergency } = body

	const atmTransactionsSnapshot = await db
		.collection(`atms/${atmID}/sessions`)
		.orderBy('timeCreated')
		.limitToLast(1)
		.get()

	const res = atmTransactionsSnapshot.docs.map(async (doc) => {
		return await db.collection(`atms/${atmID}/sessions`).doc(doc.id).update({
			isBioValidated: !!(parseInt(auth.toString())),
			isEmergency: !!(parseInt(isEmergency.toString())),
		})
	})

	return res
})
