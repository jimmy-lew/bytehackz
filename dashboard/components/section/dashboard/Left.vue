<script setup lang="ts">
import type { QuerySnapshot } from 'firebase/firestore'
import { collection, doc, getDoc, getDocs, query } from 'firebase/firestore'

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

const transactionsPerDay = ref<number[][]>([[], []])

const getTransactionsPerDay = async () => {
	// TODO: Filter based on currentRange
	const transactionQuery = query(collection(db, 'transactions'))
	const transactions = await getDocs(transactionQuery) as QuerySnapshot<Transaction>

	const data: Record<string, { total: number; flagged: number }> = {}

	for (const transactionDoc of transactions.docs) {
		const { timeCreated, sessionID, atmID } = transactionDoc.data()
		const date = timeCreated.toDate()
		const key = `${date.getDate()}/${date.getUTCMonth() + 1}`
		if (!data[key]) data[key] = { total: 0, flagged: 0 }
		data[key].total++
		const sessionDoc = await getDoc(doc(db, 'atms', atmID, 'sessions', sessionID))
		const session = sessionDoc.data() as Session
		const { isFlagged } = validateSession(session)
		if (isFlagged) data[key].flagged++
	}

	const values = Object.values(data)

	const dataArray = values.reduce((prev, { total, flagged }) => {
		prev[0].push(total)
		prev[1].push(flagged)
		return prev
	}, [[], []] as number[][])

	const meetsRange = dataArray[0].length >= currentRange.value
	const totalPadded = !meetsRange ? dataArray[0].concat(Array((currentRange.value + 1) - dataArray.length).fill(0)) : dataArray[0]
	const flaggedPadded = !meetsRange ? dataArray[1].concat(Array((currentRange.value + 1) - dataArray.length).fill(0)) : dataArray[1]

	const finalArray = [totalPadded, flaggedPadded]

	transactionsPerDay.value = finalArray
}

onMounted(async () => {
	await getTransactionsPerDay()
})

// #region Chart stuff
const chartBox = ref<Nullable<HTMLElement>>(null)
const { width } = useElementSize(chartBox)

const total = computed(() => transactionsPerDay.value[0].reduce((prev, curr) => prev + curr, 0))
const flagged = computed(() => transactionsPerDay.value[1].reduce((prev, curr) => prev + curr, 0))
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
