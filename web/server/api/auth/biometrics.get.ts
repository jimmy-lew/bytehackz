import * as fs from 'fs'

export default defineEventHandler(() => {
	if (!fs.existsSync('./auth.json'))
		fs.writeFileSync('./auth.json', JSON.stringify({}, null, '\t'))

	const rawData = fs.readFileSync('./auth.json')
	const authData = JSON.parse(rawData.toString())

	return {
		isBioValidated: authData.isBioValidated,
	}
})
