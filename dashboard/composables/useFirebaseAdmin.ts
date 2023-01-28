import { initializeApp } from 'firebase-admin'
import { cert, getApps } from 'firebase-admin/app'

export default () => {
	const { firebaseProjectId, firebaseClientEmail, firebasePrivateKey } = useRuntimeConfig()

	const hasApps = getApps().length > 0

	if (hasApps) return

	initializeApp({
		credential: cert({
			projectId: firebaseProjectId,
			clientEmail: firebaseClientEmail,
			privateKey: firebasePrivateKey?.replace(/\\n/g, '\n'),
		}),
	})
}
