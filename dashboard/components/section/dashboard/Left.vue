<script setup lang="ts">
const data = ref([
	{
		_id: 0,
		date: 'This Week',
	},
	{
		_id: 1,
		date: 'This Month',
	},
])

const date_db = ref(await lyraCreate({
	_id: 'number',
	name: 'string',
}, data.value))

const chartBox = ref<Nullable<HTMLElement>>(null)
const { width } = useElementSize(chartBox)
</script>

<template>
	<div class="flex-1 lg:mr-10 lg:flex-2 lg:max-w-[66%]">
		<div class="mb-4 flex flex-col justify-between md:flex-row">
			<div class="mb-2 shrink-0 md:mb-0 space-x-3">
				<FormSingleSelect
					class="border dark:border-white/20 rounded px-2"
					placeholder="This Week"
					:db="date_db"
					:data="data"
					:transformer="(dates: any[]) => dates.map(({ date }) => date)"
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
									Total: <span class="font-semibold whitespace-nowrap">200</span>
								</StatsDot>
								<StatsDot color="bg-rose-600">
									Flagged: <span class="font-semibold whitespace-nowrap">2</span>
								</StatsDot>
							</div>
						</div>
					</div>
				</div>
				<div class="px-2 pt-1 pb-2 text-gray-400 sm:px-3">
					<div ref="chartBox" class="flex flex-row space-x-4 p-1">
						<Chart :width="width" />
					</div>
				</div>
			</div>
		</Card>
	</div>
</template>

<style scoped>

</style>
