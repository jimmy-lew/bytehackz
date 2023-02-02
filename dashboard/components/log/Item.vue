<script setup lang="ts">
const props = withDefaults(defineProps<{
	title: string
	subtitle: string
	status: 'Completed' | 'Failed' | 'Pending' | 'Flagged' | 'Unknown' | 'Cancelled'
	duration: number
	executor: string
	linkToExecutorProfile: string
	completedAt?: Date
	profileURL?: string
	action: (...args: any[]) => any
}>(), {
	title: 'Title',
	subtitle: 'Subtitle',
	status: 'Pending',
	duration: 0,
	executor: 'jimmy-lew',
	linkToExecutorProfile: '/dashboard/profiles',
	action: () => { },
})

const theme = useColorMode()

const statusDotColor = computed(() => {
	switch (props.status) {
		case 'Completed':
			return 'bg-emerald-400'
		case 'Failed':
			return 'bg-error'
		case 'Flagged':
			return 'bg-error'
		case 'Cancelled':
			return 'bg-error'
		case 'Pending':
			return 'bg-amber-500'
		case 'Unknown':
			return 'bg-zinc-400'
		default:
			return 'bg-zinc-400'
	}
})

const timer = ref(0)
const isRefreshStopped = ref(false)

const formattedDuration = computed(() => props.duration <= 60 ? `${props.duration}s` : `${Math.round(props.duration / 60)}m ${props.duration % 60}s`)
const formattedCompletedAt = computed(() => {
	timer.value >= 3600 && (isRefreshStopped.value = true)
	if (!props.completedAt) return null
	const diff = Math.round((Date.now() - props.completedAt.getTime()) / 1000)
	if (diff < 60) return `${diff}s`
	if (diff < 3600) return `${Math.round(diff / 60)}m`
	if (diff < 86400) return `${Math.round(diff / 3600)}h`
	return `${Math.round(diff / 86400)}d`
})

onMounted(() => {
	timer.value = 0
	const interval = setInterval(() => {
		timer.value++
		if (isRefreshStopped.value) clearInterval(interval)
	}, 1000)
	onBeforeUnmount(() => clearInterval(interval))
})
</script>

<template>
	<Transition appear>
		<li tabindex="0" class="outline-none hover:scale-105 focus-within:scale-105 transition-all duration-300 ease-in-out" @click="action">
			<Card :error="status === 'Failed' || status === 'Flagged'" :radius="16">
				<div class="pl-4 pr-1.5 py-3 w-full grid grid-cols-12 text-sm">
					<div class="flex flex-col col-span-3">
						<h2 class="font-bold">
							{{ title }}
						</h2>
						<p class="text-[#666] dark:text-gray-300">
							{{ subtitle }}
						</p>
					</div>
					<div class="flex flex-col col-span-2 text-[#666] dark:text-gray-300">
						<div class="flex items-center gap-2 font-semibold">
							<span class="w-2.5 h-2.5 rounded-full" :class="statusDotColor" />
							{{ status }}
						</div>
						<div class="pl-[1.125rem]">
							{{ formattedDuration }}
						</div>
					</div>
					<div class="flex flex-col col-span-4 text-[#666] dark:text-gray-300">
						<slot />
					</div>
					<div class="flex justify-end items-center gap-2 col-span-3">
						<p class="text-[#666] dark:text-gray-300 group">
							{{ !formattedCompletedAt ? '' : `${formattedCompletedAt} ago` }} by
							<Anchor :to="linkToExecutorProfile" :color="theme.value === 'light' ? '#666' : '#d1d5db'">
								{{ executor }}
							</Anchor>
						</p>
						<div v-if="profileURL" class="w-8 h-8 rounded-full flex items-center justify-center">
							<img :src="profileURL" alt="" class="aspect-square w-8 rounded-full">
						</div>
						<div tabindex="0" class="flex items-center justify-center p-2 w-9 h-9 rounded-full hover:bg-[#e5e7eb] dark:hover:bg-[#18181b] focus:bg-[#e5e7eb] dark:focus:bg-[#18181b] outline-[0.5px] dark:outline-white/20" @click="action">
							<Icon size="16" name="zondicons:dots-horizontal-triple" />
						</div>
					</div>
				</div>
			</Card>
		</li>
	</Transition>
</template>

<style scoped>
.v-enter-active,
.v-leave-active {
  transition: opacity 0.4s ease-out;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>
