<script setup lang="ts">
const emits = defineEmits(['close'])
const modal = ref<Nullable<HTMLElement>>(null)
onClickOutside(modal, () => emits('close'))
</script>

<template>
	<div
		class="
        fixed inset-0
        w-screen h-screen
        pt-[20%]
        px-4
        bg-white/70 dark:bg-black/70
        z-[2000]
        backdrop-blur-sm
        flex justify-center"
	>
		<div class="relative w-full max-w-2xl">
			<div
				ref="modal"
				class="
                relative
                flex flex-col
                rounded-lg shadow-lg
                backdrop-blur-sm bg-transparent
                border-[0.5px] border-white/20"
			>
				<slot />
			</div>
		</div>
	</div>
</template>

<style scoped>
</style>
