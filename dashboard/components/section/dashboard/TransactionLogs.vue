<script setup lang="ts">
import { Timestamp } from 'firebase/firestore'

const transactions = useTransactions()

const {
	transactions: transactionsArray,
	flagged,
	total,
} = toRefs(transactions.value)

const theme = useColorMode()

const isLoading = ref(true)

const testTransactions: LogItem<Transaction>[] = [
	{
		id: '1',
		atmID: '000001',
		to: '104-000000-000',
		from: '101-000000-0',
		type: 'Transfer',
		sessionID: '1',
		timeCreated: Timestamp.fromDate(new Date()),
		amount: 100,
		status: 'Pending',
	},
	{
		id: '2',
		atmID: '000002',
		to: '104-000000-000',
		from: '101-000000-0',
		type: 'Withdrawal',
		sessionID: '1',
		timeCreated: Timestamp.fromDate(new Date()),
		amount: 1000,
		status: 'Pending',
	},
	{
		id: '3',
		atmID: '000001',
		to: '104-000000-000',
		from: '101-000000-0',
		type: 'Transfer',
		sessionID: '1',
		timeCreated: Timestamp.fromDate(new Date()),
		amount: 10,
		status: 'Pending',
	},
	{
		id: '1',
		atmID: '000001',
		to: '104-000000-000',
		from: '101-000000-0',
		type: 'Transfer',
		sessionID: '1',
		timeCreated: Timestamp.fromDate(new Date()),
		amount: 100,
		status: 'Completed',
	},
	{
		id: '2',
		atmID: '000002',
		to: '104-000000-000',
		from: '101-000000-0',
		type: 'Withdrawal',
		sessionID: '1',
		timeCreated: Timestamp.fromDate(new Date()),
		amount: 1000,
		status: 'Pending',
	},
	{
		id: '3',
		atmID: '000001',
		to: '104-000000-000',
		from: '101-000000-0',
		type: 'Transfer',
		sessionID: '1',
		timeCreated: Timestamp.fromDate(new Date()),
		amount: 10,
		status: 'Pending',
	},
]

// #region Filtering
const status_data = ref([
	{
		status: 'Pending',
		icon: 'color_amber-500',
	},
	{
		status: 'Completed',
		icon: 'color_emerald-400',
	},
	{
		status: 'Flagged',
		icon: 'color_error',
	},
	{
		status: 'Cancelled',
		icon: 'color_error',
	},
	{
		status: 'Failed',
		icon: 'color_error',
	},
	{
		status: 'Unknown',
		icon: 'color_zinc-400',
	},
])

const status_db = ref(await lyraCreate({
	_id: 'number',
	status: 'string',
}, status_data.value))
// #endregion
const timeRange_data = ref([
	{
		range: 'Last hour',
	},
	{
		range: 'Last 6 hours',
	},
	{
		range: 'This is a test value',
	},
])

const timeRange_db = ref(await lyraCreate({
	_id: 'number',
	range: 'string',
}, timeRange_data.value))

onMounted(() => {
	setTimeout(() => {
		isLoading.value = false
	}, 500)
})
</script>

<template>
	<SectionDashboardLogs>
		<template #filters>
			<FormSingleSelect
				class="border dark:border-white/20 rounded p-1"
				placeholder="This Week"
				has-search
				:db="timeRange_db"
				:data="timeRange_data"
				:transformer="({ range }) => range"
			/>
			<FormSingleSelect
				class="border dark:border-white/20 rounded p-1"
				placeholder="Send Help"
				:db="timeRange_db"
				:data="timeRange_data"
				:transformer="({ range }) => range"
			/>
			<FormMultiSelect
				class="border dark:border-white/20 rounded p-1"
				title="Status"
				placeholder="All statuses"
				has-search
				is-collapsed
				initial-all-selected
				:db="status_db"
				:data="status_data"
				:transformer="({ status }) => status"
			/>
		</template>
		<div v-if="isLoading" class="relative flex h-[calc(100vh-435px)] justify-center items-center text-xl font-medium">
			Fetching results
			<div class="relative">
				<Icon name="svg-spinners:3-dots-bounce" class="absolute ml-1 -top-1" />
			</div>
		</div>
		<ul v-else class="flex flex-col w-full min-h-[calc(100vh-435px)] text-xl font-medium gap-2">
			<LogTransactionItem />
			<LogTransactionItem status="Flagged" :duration="68" :completed-at="new Date('Feb 1, 2023 23:15:30')" />
			<LogTransactionItem v-for="transaction in testTransactions" :key="transaction.id" :transaction="transaction" />
			<LogTransactionItem status="Completed" :duration="138" :completed-at="new Date('Feb 2, 2023 01:01:00')" />
			<LogTransactionItem status="Completed" :duration="138" :completed-at="new Date('Jan 1, 2023 23:15:30')" />
		</ul>
		<!-- <Card v-else :radius="24" :padding="2">
            No results...
        </Card> -->
	</SectionDashboardLogs>
</template>

<style scoped>

</style>
