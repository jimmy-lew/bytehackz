<script setup lang="ts">
import { collection } from 'firebase/firestore'

// #region Select stuff
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

const handleDateRangeSelection = async ([{ date, value }]: DateRangeItem[]) => {
	console.log(date, value)
}
// #endregion

const { $firebaseStore: db } = useNuxtApp()

const transactions = computed(() => useFirestore(collection(db, 'transactions')))
const atms = computed(() => useFirestore(collection(db, 'atms')))
const sessions = computed(() => {
	transactions.value.value?.forEach(({ sessionID }) => {
		const session = useFirestore(collection(db, 'sessions', sessionID))
		console.log(session.value)
	})
})

// #region Chart stuff
const chartBox = ref<Nullable<HTMLElement>>(null)
const { width } = useElementSize(chartBox)

const data = ref([
	[10, 10, 12, 11, 10, 13, 12],
	[2, 3, 2, 1, 2, 0, 0],
])

const total = computed(() => data.value[0].reduce((prev, curr) => prev + curr, 0))
const flagged = computed(() => data.value[1].reduce((prev, curr) => prev + curr, 0))
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
						<Chart :width="width" :data="data" />
					</div>
				</div>
			</div>
		</Card>
	</div>
</template>

<style scoped>

</style>
