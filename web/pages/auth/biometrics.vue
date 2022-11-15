<script setup lang="ts">
import { doc, onSnapshot } from 'firebase/firestore'

const docIdCookie = useCookie('doc_id')

onSnapshot(doc(firestoreDb, 'atms/000001/sessions', docIdCookie.value), (doc) => {
	const { isBioValidated } = doc.data()

	if (isBioValidated)
		navigateTo('/services')
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
