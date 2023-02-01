import { doc, getDoc } from 'firebase/firestore'

export const getFirebaseDoc = async <T>(path: string, ...pathSegments: string[]) => {
	const { db } = useFirebaseClient().value
	const docSnapshot = await getDoc(doc(db, path, ...pathSegments))
	const data = docSnapshot.data() as T
	return data
}
