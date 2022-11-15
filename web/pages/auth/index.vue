<script setup lang="ts">
import { doc, onSnapshot } from 'firebase/firestore'

const docIdCookie = useCookie('doc_id')

onSnapshot(doc(firestoreDb, 'atms/000001/sessions', docIdCookie.value), (doc) => {
	const { isValidated } = doc.data()
	if (isValidated)
		navigateTo('/auth/biometrics')
})
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<Modal force-open>
			<div class="">
				Please insert your card
			</div>
		</Modal>
	</div>
</template>
