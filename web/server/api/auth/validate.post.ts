import { db } from '../lib/firebase'

export default defineEventHandler(async (event) => {
	const { auth } = getQuery(event)

	const atmTransactionsSnapshot = await db
		.collection('atm')
		.orderBy('timeCreated')
		.limitToLast(1)
		.get()

	const transactions = atmTransactionsSnapshot.docs.map((doc) => {
		db.collection('atm').doc(doc.id).update({
			isValidated: !!(parseInt(auth.toString())),
		})

		return {
			uuid: doc.id,
			...doc.data(),
		}
	})

	return transactions
})
