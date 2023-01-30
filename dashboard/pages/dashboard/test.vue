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

const errors = ref<Record<string, string>>({})
</script>

<template>
	<div class="mb-8 flex flex-row justify-between">
		<div class="space-y-1 pr-4">
			<div class="flex items-center space-x-2">
				<h1 class="text-lg font-semibold">
					Welcome, Jimmy!
				</h1>
			</div>
			<div class="flex flex-none flex-col lg:flex-row lg:items-center">
				<div class="lg:mr-2 text-sm">
					Classes last updated
					<time>today</time>
				</div>
			</div>
		</div>
	</div>
	<div class="mb-10 space-y-6 lg:flex lg:space-y-0">
		<div class="flex-1 lg:mr-10 lg:flex-2 lg:max-w-[66%]">
			<div class="mb-4 flex flex-col justify-between md:flex-row">
				<div class="mb-2 shrink-0 md:mb-0 space-x-3">
					<FormSingleSelect
						class="border dark:border-white/20 rounded px-2"
						placeholder="This Week"
						:db="date_db"
						:data="data"
						:error="errors.test"
						:transformer="(dates: any[]) => dates.map(({ date }) => date)"
					/>
				</div>
			</div>
			<div class="rounded shadow ring-1 dark:ring-white/20">
				<div class="flex h-full flex-col justify-between">
					<div class="flex flex-1 flex-col justify-between px-4 pt-1 pb-6 md:pb-4 lg:pb-2 lg:px-6">
						<div class="py-4">
							<div class="font-medium">
								Classes
							</div>
						</div>
						<div class="flex w-full flex-row justify-between font-mono text-sm">
							<div class="flex w-full flex-row justify-between font-mono text-sm">
								<div class="flex h-4 flex-wrap gap-x-4">
									<StatsDot color="bg-cyan-500">
										Upcoming: <span class="font-semibold whitespace-nowrap">0 classes</span>
									</StatsDot>
									<StatsDot color="bg-emerald-500">
										Completed: <span class="font-semibold whitespace-nowrap">2 classes</span>
									</StatsDot>
								</div>
							</div>
						</div>
					</div>
					<div class="px-2 pt-1 pb-2 text-gray-400 sm:px-3">
						<div class="flex flex-row space-x-4 p-1 overflow-x-auto">
							Graphs
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="flex-1">
			<div class="space-y-6 mt-12">
				<div class="grid grid-flow-col gap-1">
					<Stats>
						<StatsItem icon="heroicons:calendar" title="Upcoming" :value="0" />
						<StatsItem icon="heroicons:clock" title="Hours" :value="42" />
					</Stats>
				</div>
				<div class="space-y-4">
					<div>
						<StatsLinearProgress :value="10" :max="200" />
					</div>
					<div>
						<StatsLinearProgress />
					</div>
				</div>
			</div>
		</div>
	</div>
	<FooterDashboard />
</template>

<style scoped>

</style>
