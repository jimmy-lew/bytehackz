import { db } from '../lib/firebase'

export default defineEventHandler(async (event) => {
	const { auth } = getQuery(event)

	const atmTransactionsSnapshot = await db
		.collection('atms')
		.orderBy('timeCreated')
		.limitToLast(1)
		.get()

	const transactions = atmTransactionsSnapshot.docs.map((doc) => {
		db.collection('atms').doc(doc.id).update({
			isBioValidated: !!(parseInt(auth.toString())),
		})

		return {
			uuid: doc.id,
			...doc.data(),
		}
	})

	return transactions
})
