import * as fs from 'fs'

export default defineEventHandler((event) => {
	const newData = {
		data: 'new',
	}

	fs.writeFileSync('./public/test.json', JSON.stringify(newData))

	return newData
})
