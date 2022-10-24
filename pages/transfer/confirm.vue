<script setup lang="ts">
    const amount = 25001
    const account: Account = {
        name: 'John Test',
        accountNumber: '123-000000-000',
        bank: 'CITI-SG',
        balance: 2000
    }
    const mode = 'Non-immediate transfer'

    const { name, accountNumber, bank, balance} = account;
</script>

<template>
    <main class="mx-auto p-6 max-w-xl">
        <div class="flex flex-col items-center justify-center">
            <h1 class="font-semibold text-2xl mb-6">Transfer Confirmation</h1>
            <div class="card card-compact bg-white rounded-md shadow p-6 flex-row mb-4 w-full">
                <div class="flex flex-col w-1/2 content-start mr-16">
                    <p class="text-gray-400 text-sm mb-2">Amount</p>
                    <h2 class="font-semibold text-xl whitespace-nowrap">S$ {{amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")}}</h2>
                </div>
                <div class="inline-flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="w-8 h-8 fill-gray-300">
                        <path fill-rule="evenodd" d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25zm4.28 10.28a.75.75 0 000-1.06l-3-3a.75.75 0 10-1.06 1.06l1.72 1.72H8.25a.75.75 0 000 1.5h5.69l-1.72 1.72a.75.75 0 101.06 1.06l3-3z" clip-rule="evenodd" />
                    </svg>                  
                </div>
                <div class="flex flex-col w-1/2 content-end text-end ml-16">
                    <p class="text-gray-400 text-sm mb-2">To</p>
                    <h2 class="font-semibold text-xl whitespace-nowrap mb-1">{{name.toUpperCase()}}</h2>
                    <p class="text-gray-400 font-semibold text-sm whitespace-pre-line">{{accountNumber}}
                        {{bank}}
                    </p>
                </div>
            </div>
            <div class="card card-compact bg-white rounded-md shadow p-4 flex-row mb-12 w-full">
                <p class="w-1/2 text-gray-400">Payment mode</p>
                <p class="inline-flex w-1/2 font-semibold justify-end">{{mode}}</p>
            </div>
            <button class="btn rounded-md">Confirm</button>
        </div>
    </main>
</template>