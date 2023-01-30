<script setup lang="ts">
</script>

<template>
	<div class="dark:bg-[#0c0c0c] dark:text-white">
		<NavDashboard />
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
</style>
