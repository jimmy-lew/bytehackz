<script setup lang="ts">
import { collection, doc, getDoc, onSnapshot, setDoc } from 'firebase/firestore'

const transactionStore = useTransactionStore()
const userStore = useUserStore()

const { setTransaction } = transactionStore
const { setUser } = userStore

let isInitialLoad = true
let isCreated = false

onSnapshot(collection(firestoreDb, 'atms/000001/sessions'), (snapshot) => {
	if (isInitialLoad) {
		isInitialLoad = false
		return
	}

	snapshot.docChanges().forEach(async (docChange) => {
		const docIdCookie = useCookie('doc_id')
		const { uuid, transactionID } = docChange.doc.data()

		const transaction: Transaction = {
			to: '',
			from: '',
			type: '',
			timeCreated: new Date(),
			amount: 0,
			id: transactionID,
			sessionID: docChange.doc.id,
		}

		setTransaction(transaction)

		if (!isCreated) {
			await setDoc(doc(firestoreDb, 'transactions', transactionID), transaction)
			isCreated = true
		}

		// TODO: Create converter
		const user = await getDoc(doc(firestoreDb, 'users', uuid))

		setUser(user.data())

		docIdCookie.value = docChange.doc.id
		await navigateTo('/auth', { replace: true })
	})
})
</script>

<template>
	<img src="/Screensaver1.svg" alt="">
</template>
