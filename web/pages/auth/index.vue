<script setup lang="ts">
import { doc, onSnapshot } from 'firebase/firestore'

const docIdCookie = useCookie('doc_id')

onSnapshot(doc(firestoreDb, 'atms/000001/sessions', docIdCookie.value), async (doc) => {
	const { isBioValidated } = doc.data() || { isBioValidated: false }

	if (isBioValidated)
		await navigateTo('/services', { replace: true })
})
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<Modal force-open>
			<div class="">
				Biometrics
			</div>
		</Modal>
	</div>
</template>
