<script setup lang="ts">
import { Timestamp } from 'firebase/firestore'

const props = withDefaults(defineProps<{
	transaction: LogItem<Transaction>
	executor?: string
	linkToExecutorProfile?: string
	completedAt?: Date
	profileURL?: string
}>(), {
	executor: 'jimmy-lew',
	linkToExecutorProfile: '/dashboard/profiles',
	transaction: () => {
		return {
			id: '1',
			atmID: '000001',
			to: '104-000000-000',
			from: '101-000000-0',
			type: 'Withdrawal',
			sessionID: '1',
			timeCreated: Timestamp.fromDate(new Date()),
			timeCompleted: Timestamp.fromDate(new Date()),
			amount: 100,
			status: 'Pending',
		}
	},
})

const { atmID, amount, type, to, from, status, timeCreated, timeCompleted } = toRefs(props.transaction)

const duration = ref(timeCompleted?.value ? Math.round((timeCompleted?.value?.toDate().getTime() - timeCreated.value.toDate().getTime()) / 1000) : Math.round((new Date().getTime() - timeCreated.value.toDate().getTime()) / 1000))

const expand = () => {
	console.log('expand')
}

onMounted(() => {
	if (timeCompleted?.value) return
	const interval = setInterval(() => {
		duration.value++
		if (timeCompleted?.value) clearInterval(interval)
	}, 1000)
	onBeforeUnmount(() => clearInterval(interval))
})
</script>

<template>
	<LogItem v-bind="props" :action="expand" :duration="duration" :completed-at="timeCompleted?.toDate()" :status="status" :title="`${atmID}`" :subtitle="`$ ${amount}`">
		<div v-if="type === 'Transfer'" class="flex gap-4 items-center relative h-full">
			<Icon size="18" name="mingcute:transfer-2-fill" class="rotate-90" />
			<div class="relative flex flex-col h-full">
				<span>
					<span class="font-bold">To:</span> {{ to }}
				</span>
				<span>
					<span class="font-bold">From:</span> {{ from }}
				</span>
			</div>
		</div>
		<div v-if="type === 'Withdrawal'" class="flex gap-3 items-center relative h-full">
			<Icon size="24" name="ic:round-log-out" class="rotate-90" />
			<span>
				<span class="font-bold">From:</span> {{ from }}
			</span>
		</div>
	</LogItem>
</template>

<style scoped>

</style>
