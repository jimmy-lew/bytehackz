import * as fs from 'fs'

export default defineEventHandler(() => {
	if (!fs.existsSync('./tmp/auth.json'))
		fs.writeFileSync('./tmp/auth.json', JSON.stringify({}, null, '\t'))

	const rawData = fs.readFileSync('./tmp/auth.json')
	const authData = JSON.parse(rawData.toString())

	return {
		isValidated: authData.isValidated,
	}
})
