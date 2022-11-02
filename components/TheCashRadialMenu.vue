<script setup lang="ts">
const rotateClass = ref('rotate-0')

const handleClick = (rotateVal) => {
	if (rotateVal > 0)
		rotateClass.value = `rotate-${rotateVal}`
	else rotateClass.value = `-rotate-${-rotateVal}`
}
</script>

<template>
	<div id="roulette" class="relative glass-outline ml-10 w-[280px] rounded-full grid grid-cols-2 shadow-md ease-astro transition-all duration-1000 rotate-45 text-center font-medium">
		<div id="tl" class="z-50 flex justify-center items-center rounded-tl-full" @click="() => handleClick(0)">
			<div class="-rotate-45">
				$20
			</div>
		</div>
		<div id="tr" class="z-50 flex justify-center items-center rounded-tr-full" @click="() => handleClick(90)">
			<div class="-rotate-45">
				$50
			</div>
		</div>
		<div id="bl" class="z-50 flex justify-center items-center rounded-bl-full" @click="() => handleClick(270)">
			<div class="-rotate-45">
				$100
			</div>
		</div>
		<div id="br" class="z-50 flex justify-center items-center rounded-br-full" @click="() => handleClick(180)">
			<div class="-rotate-45">
				Other amount
			</div>
		</div>
		<div id="spinner" class="z-0 absolute right-[50%] bottom-[50%] w-1/2 h-1/2 glass-outline rounded-tl-full origin-bottom-right ease-astro transition-all duration-[3s]" :class="rotateClass" />
		<div class="flex flex-col justify-center items-center absolute translate-x-1/2 right-1/2 -rotate-45 -translate-y-[50%] top-[50%] bg-white dark:bg-transparent rounded-full w-28 h-28 shadow-md">
			<Icon size="32" name="fa6-solid:money-bill" />
			Fash Cash
		</div>
	</div>
</template>

<style scoped>
    #spinner {
        /* border-image: linear-gradient(#f6b73c, #4d9f0c) 30; */
    }

    #tl:hover ~ #spinner {
        @apply rotate-0
    }
    #tr:hover ~ #spinner {
        @apply rotate-90
    }
    #bl:hover ~ #spinner {
        @apply rotate-270
    }
    #br:hover ~ #spinner {
        @apply rotate-180
    }
</style>
