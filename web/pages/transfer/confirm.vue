<script setup lang="ts">
const transactionStore = useTransactionStore()
const { transactionID, transactionTo, transactionFrom, transactionAmount } = transactionStore

const mode = 'Non-immediate transfer'
const name = 'Recipient'
const bank = 'CITI-SG'

const handleClick = async () => {
	const transaction: Transaction = {
		id: transactionID,
		to: transactionTo,
		from: transactionFrom,
		amount: transactionAmount,
	}

	await useFetch('/api/transaction/transfer', {
		method: 'POST',
		body: transaction,
	})
	await navigateTo('/')
}
</script>

<template>
	<div class="flex flex-col p-12 w-full items-center justify-center">
		<h1 class="font-semibold text-2xl mb-6">
			Transfer Confirmation
		</h1>
		<div class="mx-12">
			<div class="card card-compact bg-base-100 relative glass-outline rounded-md shadow mb-4 p-6 flex-row">
				<div class="flex flex-col w-1/2 content-end mr-16">
					<p class="text-sm mb-2 h-5">
						Amount
					</p>
					<h2 class="font-semibold text-xl whitespace-nowrap">
						S$ {{ transactionAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") }}
					</h2>
				</div>
				<div class="inline-flex items-center">
					<Icon size="32" name="heroicons:arrow-right-circle" class="stroke-gray-300" />
				</div>
				<div class="flex flex-col w-1/2 content-end text-end ml-16">
					<p class="text-sm mb-2">
						To
					</p>
					<h2 class="font-semibold text-xl whitespace-nowrap mb-1">
						{{ name.toUpperCase() }}
					</h2>
					<p class="font-semibold text-sm whitespace-pre-line">
						{{ transactionTo }}
						{{ bank }}
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
