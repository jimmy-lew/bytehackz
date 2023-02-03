import { create, insert } from '@lyrasearch/lyra'

export const lyraCreate = async <T extends Schema>(schemaObj: T, data: any[]) => {
	const db = await create({
		schema: schemaObj,
	})

	data.map(async (item, _id) => await insert(db, { ...item, _id }))

	return db
}
