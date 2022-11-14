import * as fs from 'fs'

export default defineEventHandler((event) => {
	const { auth } = getQuery(event)

	if (!fs.existsSync('./tmp/auth.json'))
		fs.writeFileSync('./tmp/auth.json', JSON.stringify({}, null, '\t'))

	const rawData = fs.readFileSync('./tmp/auth.json')
	const authData = JSON.parse(rawData.toString())

	authData.isValidated = !!(parseInt(auth.toString()))

	fs.writeFileSync('./tmp/auth.json', JSON.stringify(authData, null, '\t'))

	return authData
})
