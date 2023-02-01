<script setup lang="ts">
withDefaults(defineProps<{
	title: string
}>(), {
	title: 'Logs',
})

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
</script>

<template>
	<div class="w-full border-b dark:border-white/20">
		<div class="max-w-7xl mx-auto">
			<h1 class="text-3xl font-bold my-4">
				{{ title }}
			</h1>
			<div class="flex gap-x-4 my-4">
				<FormSingleSelect
					class="border dark:border-white/20 rounded p-1"
					placeholder="This Week"
					has-search
					:db="dateRange_db"
					:data="dateRange_data"
					:transformer="({ date }) => date"
				/>
				<FormSingleSelect
					class="border dark:border-white/20 rounded p-1"
					placeholder="This Week"
					has-search
					:db="dateRange_db"
					:data="dateRange_data"
					:transformer="({ date }) => date"
				/>
				<FormSingleSelect
					class="border dark:border-white/20 rounded p-1"
					placeholder="This Week"
					has-search
					:db="dateRange_db"
					:data="dateRange_data"
					:transformer="({ date }) => date"
				/>
			</div>
			<Tabs>
				<TabsItem link="/dashboard" is-bordered>
					Dashboard
				</TabsItem>
				<TabsItem link="/dashboard/transactions" is-bordered>
					Transactions
				</TabsItem>
				<TabsItem is-bordered class="w-full text-transparent">
					.
				</TabsItem>
			</Tabs>
		</div>
	</div>
</template>

<style scoped>

</style>
