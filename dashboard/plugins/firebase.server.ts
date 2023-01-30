import admin from 'firebase-admin'

interface Error {
	code: string
	message: string
}

export default defineNuxtPlugin(async () => {
	const fbToken = useCookie('fb-token')
	const currUser = useCurrentUser()
	const tokenExpired = useTokenExpiryStatus()
	useFirebaseAdmin()

	if (!fbToken.value) return

	try {
		const foundUser = await admin.auth().verifyIdToken(fbToken.value)
		const user = await admin.auth().getUser(foundUser.uid)
		currUser.value = {
			...foundUser,
			...user,
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
