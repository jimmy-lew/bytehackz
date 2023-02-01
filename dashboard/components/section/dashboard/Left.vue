<script setup lang="ts">
import type { Unsubscribe } from 'firebase/firestore'
import { collection, onSnapshot, query } from 'firebase/firestore'

// #region Select stuff
const currentRange = ref(7)

const dateRange_data = ref<DateRangeItem[]>([
	{
		_id: 0,
		date: 'This Week',
		value: '7d',
	},
	{
		_id: 1,
		date: 'This Month',
		value: '30d',
	},
])

const dateRange_db = ref(await lyraCreate({
	_id: 'number',
	date: 'string',
}, dateRange_data.value))

const handleDateRangeSelection = async ([{ value }]: DateRangeItem[]) => currentRange.value = parseInt(value.slice(0, -1))
// #endregion

const { $firebaseStore: db } = useNuxtApp()
const lastUpdate = useDataUpdate()
const transactions = useTransactions()

const transactionsPerDay = ref<number[][]>([[], []])

let unsub: Unsubscribe

const getTransactionsPerDay = async () => {
	// TODO: Filter based on currentRange
	const transactionQuery = query(collection(db, 'transactions'))
	const newTransactions = await getFirebaseCollection<Transaction>(transactionQuery)
	transactions.value.transactions = newTransactions

	const getDateKey = (date: Date) => `${date.getDate()}/${date.getUTCMonth() + 1}`

	const data: Record<string, ChartData> = {}
	const date = new Date()

	for (let i = 0; i < currentRange.value; i++) {
		date.setDate(date.getDate() - i)
		data[getDateKey(date)] = { total: 0, flagged: 0 }
	}

	for (const { timeCreated, sessionID, atmID } of newTransactions) {
		const key = getDateKey(timeCreated.toDate())
		const { isFlagged } = await getATMSession(atmID, sessionID)
		data[key].total++
		if (isFlagged) data[key].flagged++
	}

	const values = Object.values(data)

	const dataArray = values.reduce(([totalArray, flaggedArray], { total, flagged }) => {
		totalArray.push(total)
		flaggedArray.push(flagged)
		return [totalArray, flaggedArray]
	}, [[], []] as number[][])

	transactionsPerDay.value = dataArray
}

onMounted(async () => {
	unsub = onSnapshot(collection(db, 'transactions'), async () => {
		console.log('Transactions updated...')
		await getTransactionsPerDay()
		lastUpdate.value = new Date()
	})
})

onUnmounted(() => {
	unsub()
})

// #region Chart stuff
const chartBox = ref<Nullable<HTMLElement>>(null)
const { width } = useElementSize(chartBox)

const total = computed(() => {
	const total = transactionsPerDay.value[0].reduce((prev, curr) => prev + curr, 0)
	transactions.value.total = total
	return total
})
const flagged = computed(() => {
	const flagged = transactionsPerDay.value[1].reduce((prev, curr) => prev + curr, 0)
	transactions.value.flagged = flagged
	return flagged
})
// #endregion
</script>

<template>
	<div class="flex-1 lg:mr-10 lg:flex-2 lg:max-w-[66%]">
		<div class="mb-4 flex flex-col justify-between md:flex-row">
			<div class="mb-2 shrink-0 md:mb-0 space-x-3">
				<FormSingleSelect
					class="border dark:border-white/20 rounded"
					placeholder="This Week"
					:db="dateRange_db"
					:data="dateRange_data"
					:transformer="({ date }) => date"
					@option-selected="handleDateRangeSelection"
				/>
			</div>
		</div>
		<Card :radius="16">
			<div class="flex w-full h-full flex-col justify-between">
				<div class="flex flex-1 flex-col justify-between px-4 pt-1 pb-6 md:pb-4 lg:pb-2 lg:px-6">
					<div class="py-4">
						<div class="font-medium">
							Transactions
						</div>
					</div>
					<div class="flex w-full flex-row justify-between font-mono text-sm">
						<div class="flex w-full flex-row justify-between font-mono text-sm">
							<div class="flex h-4 flex-wrap gap-x-4">
								<StatsDot color="bg-emerald-500">
									Total: <span class="font-semibold whitespace-nowrap">{{ total }}</span>
								</StatsDot>
								<StatsDot color="bg-[#0090FF]">
									Flagged: <span class="font-semibold whitespace-nowrap">{{ flagged }}</span>
								</StatsDot>
							</div>
						</div>
					</div>
				</div>
				<div class="px-2 pt-1 pb-2 text-gray-400 sm:px-3">
					<div ref="chartBox" class="flex flex-row space-x-4 p-1">
						<Chart :width="width" :data="transactionsPerDay" />
					</div>
				</div>
			</div>
		</Card>
	</div>
</template>

<style scoped>

</style>
