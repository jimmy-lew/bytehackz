<script>
setTimeout(async () => {
	await navigateTo('/')
}, 120000)
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<Modal force-open @click="() => navigateTo('/')">
			<div class="flex flex-col items-center gap-4">
				<p class="text-center font-bold">
					A scam is suspected!
					<br>
					Please contact customer service @ 1800 363 3333
				</p>
			</div>
		</Modal>
	</div>
</template>
