<script setup lang="ts">
import { doc, getDoc } from 'firebase/firestore'

const transactionStore = useTransactionStore()
const { transaction } = transactionStore
const { amount, to } = transaction

const mode = 'Non-immediate transfer'

const handleClick = async () => {
	const { data } = await useFetch('/api/auth/validate', {
		method: 'POST',
		body: transaction,
	})

	const validationScore = data.value || 1

	const scs = useCookie('SCS')
	scs.value = validationScore.toString()

	console.log(validationScore)

	if (validationScore > 0.7) {
		await navigateTo('/auth/scam')
		return
	}

	const finalTransaction = await useFetch('/api/transaction/transfer', {
		method: 'POST',
		body: transaction,
	})

	await navigateTo('/')
}

const recipient = ref<Nullable<any>>(null)

recipient.value = await getDoc(doc(firestoreDb, 'accounts', to)).then(async (docSnap) => {
	if (!docSnap.exists())
		return null
	const { uuid } = docSnap.data()
	const userSnap = await getDoc(doc(firestoreDb, 'users', uuid))
	if (!userSnap.exists())
		return null
	return userSnap.data()
})
</script>

<template>
	<div class="flex flex-col p-12 w-full items-center justify-center">
		<h1 class="font-semibold text-2xl mb-6">
			Transfer Confirmation
		</h1>
		<div class="mx-12">
			<div class="card card-compact bg-base-100 relative glass-outline rounded-md shadow mb-4 p-6 flex-row w-[420px]">
				<div class="flex w-1/2 justify-end">
					<div class="flex flex-col content-end mr-auto">
						<p class="text-sm mb-2 h-5">
							Amount
						</p>
						<h2 class="font-semibold text-xl whitespace-nowrap">
							S$ {{ amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") }}
						</h2>
					</div>
					<div class="inline-flex items-center justify-end relative left-4">
						<Icon size="32" name="heroicons:arrow-right-circle" class="stroke-gray-300" />
					</div>
				</div>
				<div class="flex flex-col w-1/2 content-end text-end">
					<p class="text-sm mb-2">
						To
					</p>
					<h2 class="font-semibold text-xl whitespace-nowrap mb-1">
						{{ recipient.name.toUpperCase() }}
					</h2>
					<p class="font-semibold text-sm whitespace-nowrap">
						{{ to }}
						<br>
						{{ recipient.bank }}
					</p>
				</div>
			</div>
			<div class="card card-compact bg-base-100 relative glass-outline rounded-md shadow mb-12">
				<div class="card-body flex-row">
					<p class="w-1/2">
						Payment mode
					</p>
					<p class="inline-flex w-1/2 font-semibold justify-end">
						{{ mode }}
					</p>
				</div>
			</div>
		</div>
		<button class="btn relative glass-outline rounded-md" @click="handleClick">
			Confirm
		</button>
	</div>
</template>
