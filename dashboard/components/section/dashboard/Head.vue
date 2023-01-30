<script setup lang="ts">
const user = useCurrentUser()
</script>

<template>
	<div class="mb-8 flex flex-row justify-between">
		<div class="space-y-1 pr-4">
			<div class="flex items-center space-x-2">
				<h1 class="text-lg font-semibold">
					Welcome, {{ user?.displayName }}!
				</h1>
			</div>
			<div class="flex flex-none flex-col lg:flex-row lg:items-center">
				<div class="lg:mr-2 text-sm">
					Transactions last updated
					<time>today</time>
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>

</style>
