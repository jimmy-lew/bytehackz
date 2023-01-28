/* eslint-disable no-console */
interface Error {
	code: string
	message: string
}

export default defineNuxtPlugin(async () => {
	const fbToken = useCookie('fb-token')
	const currUser = useCurrentUser()
	const tokenExpired = useTokenExpiryStatus()

	if (!fbToken.value) return

	try {
		const foundUser = await adminAuth.verifyIdToken(fbToken.value)
		currUser.value = {
			...foundUser,
		}
	}
	catch (e) {
		const { code, message } = e as Error

		switch (code) {
			case 'auth/id-token-expired':
				tokenExpired.value = true
				console.log('Token expired')
				break
			default:
				console.log('Error while verifying token:', message)
		}
	}
})
