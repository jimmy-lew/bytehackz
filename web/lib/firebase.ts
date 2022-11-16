import { initializeApp } from 'firebase/app'
import { getFirestore } from 'firebase/firestore'

const firebaseConfig = {
	apiKey: 'AIzaSyApztzhin12v2m5oA04fbvgr-eI9K5N0xc',
	authDomain: 'bytehackz-69420.firebaseapp.com',
	databaseURL: 'https://bytehackz-69420-default-rtdb.asia-southeast1.firebasedatabase.app',
	projectId: 'bytehackz-69420',
	storageBucket: 'bytehackz-69420.appspot.com',
	messagingSenderId: '493470788103',
	appId: '1:493470788103:web:dbfa233a978a3ca525d8a2',
}

export const firebaseApp = initializeApp(firebaseConfig)

export const firestoreDb = getFirestore(firebaseApp)
