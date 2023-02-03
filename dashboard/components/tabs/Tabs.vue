<script setup lang="ts">

</script>

<template>
	<div class="tabs flex items-end flex-nowrap mx-auto overflow-x-auto">
		<slot />
	</div>
</template>

<style>
.tabs > .tab:not(:first-child) {
	@apply border-l-0;
}

.tabs > .tab.bordered:first-child {
	@apply rounded-tl-md;
}

.tabs > .tab.bordered:last-child {
	@apply rounded-tr-md;
}
</style>
