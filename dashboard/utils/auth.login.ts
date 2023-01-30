import { GoogleAuthProvider, signInWithPopup } from 'firebase/auth'

export const login = async () => {
	const { auth } = useFirebaseClient().value
	if (!auth) return
	await signInWithPopup(auth, new GoogleAuthProvider())
	navigateTo('/dashboard')
}
