// import { db } from './lib/firebase'

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const { featScore } = body

	return body
})
