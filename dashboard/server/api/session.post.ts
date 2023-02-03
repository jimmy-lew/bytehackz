export default defineEventHandler(async (event) => {
	const body = await readBody(event)

	const { token } = body

	if (token) {
		setCookie(event, 'fb-token', token, {
			domain: '',
			maxAge: 60 * 60 * 8,
			path: '/',
			sameSite: 'lax',
			secure: true,
			httpOnly: true,
		})
		return 'auth cookie set'
	}

	setCookie(event, 'fb-token', '', {
		maxAge: -1,
		path: '/',
		sameSite: 'lax',
		secure: true,
		httpOnly: true,
	})
	return 'auth cookie cleared'
})
