import { GoogleAuthProvider, signInWithPopup } from 'firebase/auth'

export const login = () => {
	const { auth } = useFirebaseClient().value
	if (!auth) return
	signInWithPopup(auth, new GoogleAuthProvider())
}
