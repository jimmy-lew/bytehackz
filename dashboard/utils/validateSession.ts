export const validateSession = (session: Session) => {
	if (!session) {
		return {
			isFlagged: false,
			error: true,
		}
	}
	const { overallScore } = session
	const isFlagged = overallScore > 0.7

	return {
		isFlagged,
		error: false,
	}
}
