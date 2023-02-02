import express from 'express';
import { createServer } from 'http';
import { initializeApp } from 'firebase/app'
import { getFirestore } from 'firebase/firestore'
import { generateTransaction } from './generate.transaction';
import { faker } from '@faker-js/faker'
const port = parseInt(process.env.PORT) || 8000;
const config = {
	apiKey: 'AIzaSyApztzhin12v2m5oA04fbvgr-eI9K5N0xc',
	authDomain: 'bytehackz-69420.firebaseapp.com',
	databaseURL: 'https://bytehackz-69420-default-rtdb.asia-southeast1.firebasedatabase.app',
	projectId: 'bytehackz-69420',
	storageBucket: 'bytehackz-69420.appspot.com',
	messagingSenderId: '493470788103',
	appId: '1:493470788103:web:dbfa233a978a3ca525d8a2',
}

const firebaseApp = initializeApp(config)
const db = getFirestore(firebaseApp)

const app = express()
    , server = createServer(app)

server.listen(port, async () => {
    console.info(`⚡️ [server]: Server is running at http://localhost:${port}`)
    // await generateBackdatedTransactionsLoop()
});

let count = 0

const transactionLoop = setInterval(async () => {
    count++
    await generateTransaction(db, new Date(), count)
}, 90000);

// const generateBackdatedTransactionsLoop = async () => {
//     for (let i = 0; i < 500; i++) {
//         count++
//         const date = faker.date.between('2023-01-01', '2023-02-01')
//         await generateTransaction(db, date, count)
//     }
// }
