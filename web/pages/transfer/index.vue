<script setup lang="ts">
import { doc, getDoc } from 'firebase/firestore'

const transactionStore = useTransactionStore()
const { setTransactionFrom } = transactionStore

const userStore = useUserStore()
const { user } = userStore
const { accounts: userAccounts } = user

const handleClick = async (accNo: string) => {
	setTransactionFrom(accNo)
	await navigateTo('/transfer/to')
}

const accounts = ref<any[]>([])

userAccounts.forEach(async (accountID) => {
	const ref = doc(firestoreDb, 'accounts', accountID)
	const docSnap = await getDoc(ref)
	if (!docSnap.exists())
		return
	accounts.value.push({
		id: docSnap.id,
		...docSnap.data(),
	})
})
</script>

<template>
	<div class="flex flex-col relative p-12 w-full ease-astro">
		<!-- <Header username="Test" /> -->
		<div class="flex flex-col justify-center items-center w-full h-full space-y-16">
			<h1 class="text-3xl font-medium">
				Please select an account to access
			</h1>
			<div class="flex justify-evenly items-center w-full">
				<div v-if="accounts.length <= 0" class="">
					Loading
				</div>
				<BaseCard v-for="{ id } in accounts" v-else :key="id" round="lg" size="8" class="font-medium" @click="() => handleClick(id)">
					<div class="flex flex-col items-center justify-center text-xl">
						<Icon v-if="id.length > 10" size="48" name="fluent:savings-16-regular" />
						<Icon v-else size="48" name="fluent:vault-16-regular" />
						<p v-if="id.length > 10">
							Savings Account
						</p>
						<p v-else>
							Current Account
						</p>
						<div class="flex flex-col items-center justify-center text-xs mt-2">
							{{ id }}
							<span class="text-gray-400">
								Singapore Dollar
							</span>
						</div>
					</div>
				</BaseCard>
				<!-- <BaseCard round="lg" size="8" class="font-medium" @click="() => handleClick('200-000000-0')">
					<div class="flex flex-col items-center justify-center text-xl">
						<Icon size="48" name="fluent:savings-16-regular" />
						Savings Account
						<div class="flex flex-col items-center justify-center text-xs mt-2">
							200-000000-0
							<span class="text-gray-400">
								Singapore Dollar
							</span>
						</div>
					</div>
				</BaseCard> -->
			</div>
		</div>
	</div>
</template>
