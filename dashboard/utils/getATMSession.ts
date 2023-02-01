import { doc, getDoc } from 'firebase/firestore'

export const getATMSession = async (atmID: string, sessionID: string) => {
	const { db } = useFirebaseClient().value
	const sessionDoc = await getDoc(doc(db, 'atms', atmID, 'sessions', sessionID))
	const session = sessionDoc.data() as Session
	const { isFlagged } = validateSession(session)
	return {
		...session,
		isFlagged,
	}
}
