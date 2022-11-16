import { db } from '../lib/firebase'

// #region Score Calculation Methods

// const getTransactionHistory = async (accountNo: string, noDays: number, isSender = false) => {
// 	return await db
// 		.collection('transactions')
// 		.where('timeCreated', '>=', new Date().setDate(new Date().getDate() - noDays))
// 		.where(`${isSender ? 'from' : 'to'}`, '==', accountNo)
// 		.get()
// 		.then((snapShot) => {
// 			return snapShot.docs.map((doc) => {
// 				return {
// 					id: doc.id,
// 					...doc.data(),
// 				}
// 			})
// 		})
// }

// const getTransactionHistoryScore = async (transactions: any[]) => {
// 	const transactionHistoryScoreTotal = await transactions.reduce(async (partial, transaction) => {
// 		const { sessionID } = transaction
// 		const session = await sessionRef.doc(sessionID).get()
// 		const sessionData = session.data()
// 		if (!sessionData)
// 			return partial
// 		const { overallScore } = sessionData
// 		return overallScore + partial
// 	}, 0)

// 	return transactionHistoryScoreTotal / transactions.length
// }

const getAgeScore = (date: Date) => {
	return 1 - (1 / Math.abs(new Date().getFullYear() - date.getFullYear()))
}

const getSenderCareerScore = (career: string) => {
	return career === 'UNEMPLOYED' ? 1 : 0
}

const getGuardianScore = (guardianUUID: string) => {
	return guardianUUID.length > 0 ? 1 : 0
}

const getSenderConfidenceScore = (ageScore: number, careerScore: number, guardianScore: number, fearScore: number) => {
	return (ageScore + careerScore + guardianScore + fearScore) / 4
}

const getAccountAgeScore = (date: Date) => {
	return 1 - (1 / Math.ceil((new Date().getTime() - date.getTime()) / (1000 * 3600 * 24)))
}

const getRecipientConfidenceScore = (accountAgeScore: number, transactionHistoryScore: number) => {
	return (accountAgeScore + transactionHistoryScore) / 2
}

const getTransactionConfidenceScore = (averageTransactionAmount: number, currentTransactionAmount: number) => {
	if (currentTransactionAmount < averageTransactionAmount)
		return 0
	return 1 - (1 / (currentTransactionAmount - averageTransactionAmount))
}
// #endregion

export default defineEventHandler(async (event) => {
	const body = await useBody(event)

	const { to, from, sessionID, amount } = body

	const accountRef = db.collection('accounts')
	const senderAccount = await accountRef.doc(from).get()
	const senderAccountData = senderAccount.data()

	if (!senderAccountData)
		return

	const { uuid: senderUUID } = senderAccountData

	const userRef = db.collection('users')
	const sessionRef = db.collection('atms/000001/sessions')
	const session = await sessionRef.doc(sessionID).get()
	const sessionData = session.data()
	const sender = await userRef.doc(senderUUID).get()
	const senderData = sender.data()

	if (!senderData || !sessionData)
		return

	const { guardianUUID, occupation: senderOccupation, dateOfBirth, averageTransactionAmount } = senderData
	const ageScore = getAgeScore(dateOfBirth.toDate())
	const careerScore = getSenderCareerScore(senderOccupation)
	const guardianScore = getGuardianScore(guardianUUID)

	const { fearScore } = sessionData

	const senderConfidenceScore = getSenderConfidenceScore(ageScore, careerScore, guardianScore, fearScore)
	const transactionConfidenceScore = getTransactionConfidenceScore(averageTransactionAmount, amount)
	let recipientConfidenceScore = 0

	if (to) {
		const recipientAccount = await accountRef.doc(to).get()
		const recipientAccountData = recipientAccount.data()

		if (!recipientAccountData)
			return

		const { uuid: recipientUUID } = recipientAccountData

		const recipient = await userRef.doc(recipientUUID).get()
		const recipientData = recipient.data()

		if (!recipientData)
			return

		const { accountCreationDate, averageTransactionScore } = recipientData
		const accountAgeScore = getAccountAgeScore(accountCreationDate.toDate())
		recipientConfidenceScore = getRecipientConfidenceScore(accountAgeScore, averageTransactionScore)
	}

	const overallScore = (senderConfidenceScore + recipientConfidenceScore + transactionConfidenceScore) / (recipientConfidenceScore === 0 ? 2 : 3)

	return overallScore
})
