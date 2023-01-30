<script setup lang="ts">

</script>

<template>
	<div class="flex-1">
		<div class="space-y-6 mt-12">
			<div class="grid grid-flow-col gap-1">
				<Stats :radius="16">
					<StatsItem icon="heroicons:calendar" title="Upcoming" :value="0" />
					<StatsItem icon="heroicons:clock" title="Hours" :value="42" />
				</Stats>
			</div>
			<div class="space-y-4">
				<div>
					<StatsLinearProgress :value="10" :max="200" />
				</div>
				<div>
					<StatsLinearProgress color="#06b6d4" :value="20" />
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>

</style>
