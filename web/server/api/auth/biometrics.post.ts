import * as fs from 'fs'

export default defineEventHandler((event) => {
	const { auth } = getQuery(event)

	if (!fs.existsSync('./public/auth.json'))
		fs.writeFileSync('./public/auth.json', JSON.stringify({}, null, '\t'))

	const rawData = fs.readFileSync('./public/auth.json')
	const authData = JSON.parse(rawData.toString())

	authData.isBioValidated = !!(parseInt(auth.toString()))

	fs.writeFileSync('./public/auth.json', JSON.stringify(authData, null, '\t'))

	return authData
})
