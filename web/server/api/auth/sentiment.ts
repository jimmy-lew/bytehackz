import * as fs from 'fs'

export default defineEventHandler((event) => {
	const { auth } = getQuery(event)

	const newData = {
		data: auth,
	}

	fs.writeFileSync('./public/test.json', JSON.stringify(newData))

	return newData
})
