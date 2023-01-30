import { create, insert } from '@lyrasearch/lyra'

export const lyraCreate = async <T extends Schema>(schemaObj: T, data: any[]) => {
	const db = await create({
		schema: schemaObj,
	})

	for (const item of data) await insert(db, item)

	return db
}
