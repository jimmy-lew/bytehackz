<script setup lang="ts">

</script>

<template>
	<main class="p-8 relative flex w-full">
		<div class="flex w-1/2 h-full p-4">
			<div class="card relative w-full rounded-2xl shadow-md">
				<div class="relative card-body glass-outline rounded-2xl">
					<div class="my-auto flex flex-col items-center justify-center">
						<slot name="left" />
					</div>
				</div>
			</div>
		</div>
		<div class="flex w-1/2 h-full p-4">
			<slot name="right" />
		</div>
	</main>
</template>

<style scoped>

</style>
