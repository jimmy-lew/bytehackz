import { db } from '../lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const { id, to, from, amount } = body

	await db.collection('transactions').doc(id).update({
		to,
		from,
		amount,
		timeCompleted: new Date(),
		type: 'Transfer',
	})

	return body
})
