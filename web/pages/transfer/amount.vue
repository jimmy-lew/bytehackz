<script setup lang="ts">
const accStore = useAccountStore()
const { transferFrom, transferTo } = accStore
</script>

<template>
	<div>
		{{ transferFrom }}
		{{ transferTo }}
	</div>
</template>

<style scoped>

</style>
