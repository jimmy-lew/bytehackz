<script setup lang="ts">
const transformClass = ref('rounded-tl-full')
const amount = ref(20)

const handleClick = (location: string, withdrawAmt: number) => {
	let xTransform = ''
	let yTransform = ''
	if (location.slice(0, 1) === 'b')
		yTransform = 'translate-y-full'
	if (location.slice(1) === 'r')
		xTransform = 'translate-x-full'
	transformClass.value = `${xTransform} ${yTransform} rounded-${location}-full`

	amount.value = withdrawAmt
}
</script>

<template>
	<div id="roulette" class="relative glass-outline my-auto ml-auto w-[240px] h-[280px] rounded-full grid grid-cols-2 shadow-md ease-astro transition-all duration-1000 rotate-45 text-center font-medium">
		<div id="tl" class="z-50 flex justify-center items-center rounded-tl-full" @click="() => handleClick('tl', 20)">
			<div class="-rotate-45">
				$20
			</div>
		</div>
		<div id="tr" class="z-50 flex justify-center items-center rounded-tr-full" @click="() => handleClick('tr', 50)">
			<div class="-rotate-45">
				$50
			</div>
		</div>
		<div id="bl" class="z-50 flex justify-center items-center rounded-bl-full" @click="() => handleClick('bl', 100)">
			<div class="-rotate-45">
				$100
			</div>
		</div>
		<div id="br" class="z-50 flex justify-center items-center rounded-br-full" @click="() => handleClick('br', null)">
			<div class="-rotate-45">
				Other amount
			</div>
		</div>
		<div id="spinner" class="z-0 absolute right-[50%] bottom-[50%] w-1/2 h-1/2 glass-outline origin-bottom-right ease-astro transition-all duration-[2.5s]" :class="transformClass" />
		<NuxtLink :to="`/withdraw?amount=${amount}`" class="z-[100] flex flex-col justify-center items-center absolute translate-x-1/2 right-1/2 -rotate-45 -translate-y-1/2 top-1/2 bg-white dark:bg-transparent rounded-full w-28 h-28 shadow-md">
			<Icon size="32" name="fa6-solid:money-bill" />
			Fash Cash
		</NuxtLink>
	</div>
</template>

<style scoped>
    #tl:hover ~ #spinner {
        @apply rounded-tl-full
    }
    #tr:hover ~ #spinner {
        @apply translate-x-full translate-y-0 rounded-none rounded-tr-full
    }
    #bl:hover ~ #spinner {
        @apply translate-x-0 translate-y-full rounded-none rounded-bl-full
    }
    #br:hover ~ #spinner {
        @apply translate-x-full translate-y-full rounded-none rounded-br-full
    }
</style>
