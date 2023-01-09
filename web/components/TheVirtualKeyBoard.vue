<script setup lang="ts">
const keyStore = useKeyInputStore()

const {
	appendInput,
	backspace,
	clearInput,
} = toRefs(keyStore)

onKeyStroke(['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'], e => appendInput.value(e.key))
onKeyStroke('Backspace', () => backspace.value())
</script>

<template>
	<div class="grid grid-cols-3 h-fit gap-8 text-lg">
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('1')">
			1
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('2')">
			2
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('3')">
			3
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('4')">
			4
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('5')">
			5
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('6')">
			6
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('7')">
			7
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('8')">
			8
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('9')">
			9
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => backspace()">
			<Icon name="heroicons:backspace" />
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center" @click="() => appendInput('0')">
			0
		</div>
		<div class="relative flex items-center justify-center bg-white dark:bg-base-cotent glass-outline rounded-full w-16 h-16 text-center text-base" @click="() => clearInput()">
			CLR
		</div>
	</div>
</template>

<style scoped>

</style>
