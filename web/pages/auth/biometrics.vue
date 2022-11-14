<script setup lang="ts">
// TODO: Migrate polling to websocket / rtdb
async function poll() {
	const { data, refresh } = await useFetch('/api/auth/biometrics')

	if (!data.value.isBioValidated) {
		refresh()
		setTimeout(poll, 2000)
	}
	else {
		navigateTo('/services')
	}
}

poll()
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<Modal no-close-button force-open>
			<div class="">
				Biometrics
			</div>
		</Modal>
	</div>
</template>
