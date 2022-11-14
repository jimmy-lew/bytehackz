import * as fs from 'fs'

export default defineEventHandler((event) => {
	const { auth: hasDistress } = getQuery(event)

	if (!fs.existsSync('./scs.json'))
		fs.writeFileSync('./scs.json', JSON.stringify({}, null, '\t'))

	const rawData = fs.readFileSync('./scs.json')
	const scsData = JSON.parse(rawData.toString())

	scsData.hasDistress = !!(parseInt(hasDistress.toString()))

	fs.writeFileSync('./scs.json', JSON.stringify(scsData, null, '\t'))

	return scsData
})
