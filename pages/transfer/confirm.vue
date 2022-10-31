<script setup lang="ts">
const amount = 25001
const account: Account = {
	name: 'John Test',
	accountNumber: '123-000000-000',
	bank: 'CITI-SG',
	balance: 2000,
}
const mode = 'Non-immediate transfer'

const { name, accountNumber, bank, balance } = account
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
						S$ {{ amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") }}
					</h2>
				</div>
				<div class="inline-flex items-center">
					<Icon size="32" name="heroicons:arrow-right-circle-20-solid" class="stroke-gray-300" />
				</div>
				<div class="flex flex-col w-1/2 content-end text-end ml-16">
					<p class="text-sm mb-2">
						To
					</p>
					<h2 class="font-semibold text-xl whitespace-nowrap mb-1">
						{{ name.toUpperCase() }}
					</h2>
					<p class="font-semibold text-sm whitespace-pre-line">
						{{ accountNumber }}
						{{ bank }}
					</p>
				</div>
			</div>
			<div class="card card-compact bg-base-100 rounded-md shadow mb-12">
				<div class="card-body relative glass-outline flex-row">
					<p class="w-1/2">
						Payment mode
					</p>
					<p class="inline-flex w-1/2 font-semibold justify-end">
						{{ mode }}
					</p>
				</div>
			</div>
		</div>
		<button class="btn rounded-md">
			Confirm
		</button>
	</div>
</template>
