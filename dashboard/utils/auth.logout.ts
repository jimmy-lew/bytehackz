import { signOut } from 'firebase/auth'

export const logout = async () => {
	const { auth } = useFirebaseClient().value
	if (!auth) return
	await signOut(auth)
	navigateTo('/')
}
