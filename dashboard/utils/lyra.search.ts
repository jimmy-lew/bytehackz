import type { Lyra } from '@lyrasearch/lyra'
import { search } from '@lyrasearch/lyra'

export const lyraSearch = async (db: Lyra<Schema>, data: any[], term: string) => {
	const res = await search(db, {
		term,
		properties: '*',
	})

	const dataHits = res.hits.map(({ document: { _id } }) => data[_id])

	return dataHits
}
