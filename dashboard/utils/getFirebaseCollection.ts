import type { DocumentData, Query } from 'firebase/firestore'
import { getDocs } from 'firebase/firestore'

export const getFirebaseCollection = async <T>(collectionQuery: Query<DocumentData>) => {
	const querySnapshot = await getDocs(collectionQuery)
	const data = querySnapshot.docs.map(doc => doc.data()) as T[]
	return data
}
