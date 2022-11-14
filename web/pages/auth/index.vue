<script setup lang="ts">
// TODO: Migrate polling to websocket / rtdb
async function poll() {
	const { data, refresh } = await useFetch('/api/auth/validate')

	if (!data.value.isValidated) {
		refresh()
		setTimeout(poll, 2000)
	}
	else {
		navigateTo('/auth/biometrics')
	}
}

poll()
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<Modal no-close-button force-open>
			<div class="">
				Please insert your card
			</div>
		</Modal>
	</div>
</template>
