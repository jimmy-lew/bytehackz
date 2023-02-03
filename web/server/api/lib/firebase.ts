import { getFirestore } from 'firebase-admin/firestore'
import { cert, getApps, initializeApp } from 'firebase-admin/app'

const apps = getApps()

if (!apps.length) {
	initializeApp({
		credential: cert({
			projectId: useRuntimeConfig().firebaseProjectId,
			clientEmail: useRuntimeConfig().firebaseClientEmail,
			privateKey: useRuntimeConfig().firebasePrivateKey?.replace(/\\n/g, '\n'),
		}),
	})
}

export const db = getFirestore()
