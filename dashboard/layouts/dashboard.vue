<template>
	<NavDashboard />
	<main class="mx-auto w-full flex-1">
		<slot />
	</main>
	<div class="fixed bottom-0 right-0 flex flex-col gap-4 p-4">
		<Card tabindex="0" class="transition-all duration-300 ease-in focus:scale-110 hover:scale-110">
			<div class="flex items-center justify-center w-4 h-4">
				?
			</div>
		</Card>
		<Card tabindex="0" class="transition-all duration-300 ease-in focus:scale-110 hover:scale-110">
			<div class="flex items-center justify-center w-4 h-4">
				/
			</div>
		</Card>
	</div>
</template>

<style scoped>

</style>
