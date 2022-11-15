<script setup lang="ts">
import { collection, doc, getDoc, onSnapshot, setDoc } from 'firebase/firestore'

const transactionStore = useTransactionStore()
const userStore = useUserStore()

const { setTransactionID } = transactionStore
const { setUser } = userStore

let isInitialLoad = true

onSnapshot(collection(firestoreDb, 'atms/000001/sessions'), (snapshot) => {
	if (isInitialLoad) {
		isInitialLoad = false
		return
	}

	snapshot.docChanges().forEach(async (docChange) => {
		const docIdCookie = useCookie('doc_id')
		const { uuid, transactionID } = docChange.doc.data()

		setTransactionID(transactionID)

		const transaction: Transaction = {
			to: '',
			from: '',
			amount: 0,
			id: transactionID,
		}

		await setDoc(doc(firestoreDb, 'transactions', transactionID), transaction)

		const user = await getDoc(doc(firestoreDb, 'users', uuid))

		setUser(user.data())

		docIdCookie.value = docChange.doc.id
		navigateTo('/auth/')
	})
})
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<!-- <Header username="Jimmy" />
		<Banner>
			<Icon size="24" name="maki:caution" />
			<span>Scam warning banner</span>
		</Banner>
		<div class="flex gap-8">
			<LinkCard title="Withdrawal" href="/withdraw">
				<Icon size="36" name="fluent:money-hand-24-regular" class="" />
			</LinkCard>
			<ul class="flex flex-col gap-8">
				<LinkCard title="Payment" href="/">
					<Icon size="36" name="fa6-solid:file-signature" class="" />
				</LinkCard>
				<LinkCard title="Transfer" href="/transfer">
					<Icon size="36" name="heroicons:arrows-right-left-20-solid" />
				</LinkCard>
			</ul>
			<TheCashRadialMenu />
			<div class="ml-auto">
				<LinkCard title="More" href="/services" class="h-2/3">
					<Icon size="32" name="heroicons-solid:dots-horizontal" class="" />
				</LinkCard>
			</div>
		</div>
		<Modal>
			Sample Scam Warning Modal
		</Modal> -->
	</div>
</template>
