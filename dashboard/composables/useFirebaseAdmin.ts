import admin from 'firebase-admin'
import { getApps } from 'firebase-admin/app'

export default () => {
	const { firebaseProjectId, firebaseClientEmail, firebasePrivateKey } = useRuntimeConfig()

	const hasApps = getApps().length > 0

	if (hasApps) return

	admin.initializeApp({
		credential: admin.credential.cert({
			projectId: firebaseProjectId,
			clientEmail: firebaseClientEmail,
			privateKey: firebasePrivateKey?.replace(/\\n/g, '\n'),
		}),
	})
}
