<script setup lang="ts">
const route = useRoute()
</script>

<template>
	<div>
		{{ route.query }}
	</div>
</template>

<style scoped>

</style>
