import { auth, initializeApp } from 'firebase-admin'
import { cert } from 'firebase-admin/app'

const { firebaseProjectId, firebaseClientEmail, firebasePrivateKey } = useRuntimeConfig()

export const adminApp = initializeApp({
	credential: cert({
		projectId: firebaseProjectId,
		clientEmail: firebaseClientEmail,
		privateKey: firebasePrivateKey?.replace(/\\n/g, '\n'),
	}),
})

export const adminAuth = auth()
