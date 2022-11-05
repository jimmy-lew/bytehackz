<script setup lang="ts">
const { username } = defineProps<{
	username: string
}>()
</script>

<template>
	<div class="flex items-center">
		<div class="inline-flex w-1/2 justify-start">
			<h1 class="whitespace-pre-line text-2xl">
				Welcome! {{ username }}
			</h1>
		</div>
		<div class="inline-flex w-1/2 justify-end h-fit items-center">
			<div class="btn btn-ghost btn-circle">
				<Icon size="24" name="heroicons:language-20-solid" />
			</div>
			<div class="divider divider-horizontal mx-0" />
			<NuxtLink to="/" class="flex flex-col items-center text-xs btn btn-ghost btn-circle">
				<Icon size="24" name="heroicons:arrow-right-on-rectangle-20-solid" />
				<p class="text-gray-400">
					Exit
				</p>
			</NuxtLink>
		</div>
	</div>
</template>

<style scoped>

</style>
