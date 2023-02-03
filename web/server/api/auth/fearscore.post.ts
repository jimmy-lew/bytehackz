import { db } from '../lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const atmID = '000001'
	const { fearScore } = body

	const atmTransactionsSnapshot = await db
		.collection(`atms/${atmID}/sessions`)
		.orderBy('timeCreated')
		.limitToLast(1)
		.get()

	await atmTransactionsSnapshot.docs.forEach((doc) => {
		db.collection(`atms/${atmID}/sessions`).doc(doc.id).update({
			fearScore,
		})
	})

	return {}
})