const setServerSession = (token: string) => {
	return useFetch('/api/session', {
		method: 'POST',
		body: {
			token,
		},
	})
}

export default defineNuxtPlugin((nuxtApp) => {
	const currUser = useCurrentUser()
	const { auth, app } = useFirebaseClient().value

	nuxtApp.hooks.hook('app:mounted', () => {
		auth.onIdTokenChanged(async (user) => {
			if (user) {
				const token = await user.getIdToken()
				setServerSession(token)
				currUser.value = {
					...user,
				}
			}
			else {
				setServerSession('')
				currUser.value = null
			}
		})
	})

	return {
		provide: {
			firebaseApp: app,
			firebaseAuth: auth,
		},
	}
})
