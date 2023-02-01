export const getATMSession = async (atmID: string, sessionID: string) => {
	const session = await getFirebaseDoc<Session>('atms', atmID, 'sessions', sessionID)
	const { isFlagged } = validateSession(session)
	return {
		...session,
		isFlagged,
	}
}
