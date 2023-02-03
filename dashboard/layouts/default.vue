<script setup lang="ts">
</script>

<template>
	<div class="bg-white text-black dark:bg-[#0c0c0c] dark:text-white select-none">
		<slot />
	</div>
</template>

<style global>
::-webkit-scrollbar {
    @apply w-2 h-2 bg-transparent
}
::-webkit-scrollbar-track {
	@apply dark:bg-[#27272a]
}
::-webkit-scrollbar-thumb {
    @apply rounded-full dark:bg-[#3f3f46]
}

.glow::before {
    @apply content-default absolute inset-0;
    background: radial-gradient(var(--radius) circle at var(--x) var(--y),hsla(0,0%,100%,.5),transparent 40%);
    border-radius: inherit;
}

html[data-theme="light"] .glow::before {
    background: radial-gradient(var(--radius) circle at var(--x) var(--y),rgba(214, 49, 49, 0),transparent 40%);
}

.apexcharts-tooltip {
    @apply text-black dark:text-white dark:!bg-[#18181b] !rounded-md !border-0 !shadow-md
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease-in-out;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.right-enter-active,
.right-leave-active {
  transition: all 0.5s ease-in-out;
}

.right-enter-from,
.right-leave-to {
  transform: translateX(100%);
}

.top-enter-active,
.top-leave-active {
  transition: all 0.5s ease-in-out;
}

.top-enter-from,
.top-leave-to {
  transform: translateY(100%);
}
</style>
