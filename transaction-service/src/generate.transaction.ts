import { randomUUID } from "crypto"
import { Timestamp, setDoc, doc, updateDoc, Firestore, writeBatch } from "firebase/firestore"
import { TransactionType, Session, Transaction } from "./types"
import { faker } from '@faker-js/faker'

export const generateTransaction = async (db: Firestore, creationDate: Date, trackerID: number) => {
    const accountArray = ['101-000000-0', '102-000000-000', '103-000000-000', '104-000000-000', '105-000000-0']
    const accountMap = {
        '101-000000-0': 'be87fd5e-4349-4083-b419-8e24661bba10',
        '102-000000-000': '367c4f10-8613-4eb0-a61b-cad7c67322f1',
        '103-000000-000': 'f33f888e-4a0f-4645-9ce5-baff42a5c7dc',
        '104-000000-000': '3ac345e2-2a54-46f6-b811-ebdf7d321a74',
        '105-000000-0': '3ac345e2-2a54-46f6-b811-ebdf7d321a74',
    }

    const atmID = faker.helpers.arrayElement(['000001', '000002', '000003', '000004', '000005'])
    const transactionID = randomUUID()
    const sessionID = `${randomUUID()}-${creationDate.toLocaleTimeString('it-IT').replace(/:/g, '')}`
    const timeCreated = Timestamp.fromDate(creationDate)
    const from = faker.helpers.arrayElement(accountArray)
    const type = faker.helpers.arrayElement(['Transfer', 'Withdrawal']) as TransactionType

    const session: Session = {
		uuid: accountMap[from],
		isValidated: true,
		isBioValidated: true,
		isTampered: false,
		fearScore: 0,
		isFailure: false,
		isEmergency: false,
		appScore: 0,
		overallScore: faker.datatype.float({min: 0.5, max: 0.81, precision: 0.01}),
		transactionID,
		timeCreated,
	}

    const transaction: Transaction = {
        id: randomUUID(),
        amount: faker.datatype.number({min: 10, max: 1000}),
        atmID,
        to: type !== 'Transfer' ? '' : faker.helpers.arrayElement([...accountArray.filter((acc) => acc !== from)]),
        from,
        type,
        sessionID,
        timeCreated,
    }

    const batchOne = writeBatch(db)

    batchOne.set(doc(db, 'atms', atmID, 'sessions', sessionID), session)
    batchOne.set(doc(db, 'transactions', transactionID), transaction)

    await batchOne.commit()

    console.info(`⚡️ [server]: Transaction ${trackerID} created at ${timeCreated.toDate().toLocaleTimeString()}`);

    const delay = faker.datatype.number({min: 32000, max: 246000})

    setTimeout(async () => {
        const batchTwo = writeBatch(db)
        const timeCompleted = Timestamp.fromDate(new Date(timeCreated.toDate().getTime() + delay))
        console.info(`⚡️ [server]: Transaction ${trackerID} completed at ${timeCompleted.toDate().toLocaleTimeString()}`);
        
        batchTwo.update(doc(db, 'atms', atmID, 'sessions', sessionID), {
            timeCompleted,
        })

        batchTwo.update(doc(db, 'transactions', transactionID), {
            timeCompleted,
        })

        await batchTwo.commit()
    }, delay)
}