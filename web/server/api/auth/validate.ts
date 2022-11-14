import * as fs from 'fs'

export default defineEventHandler((event) => {
	const { auth } = getQuery(event)

	if (!fs.existsSync('./auth.json'))
		fs.writeFileSync('./auth.json', JSON.stringify({}, null, '\t'))

	const rawData = fs.readFileSync('./auth.json')
	const authData = JSON.parse(rawData.toString())

	authData.isValidated = !!(parseInt(auth.toString()))

	fs.writeFileSync('./auth.json', JSON.stringify(authData, null, '\t'))

	return authData
})
