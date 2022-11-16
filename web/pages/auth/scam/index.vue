<script setup lang="ts">
import { doc, onSnapshot, updateDoc } from 'firebase/firestore'

onSnapshot(doc(firestoreDb, 'atms/000001/sessions', useCookie('doc_id').value), async (doc) => {
	if (!doc.exists())
		return
	const { appScore } = doc.data()
	if (appScore > 0) {
		const scs = parseInt(useCookie('scs').value)
		const overallScore = (scs + appScore) / 2

		await updateDoc(doc.ref, {
			overallScore,
		})

		if (overallScore > 0.7) {
			await navigateTo('/scam/detected')
			return
		}

		await navigateTo('/services')
	}
})
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<Modal force-open>
			<div class="flex flex-col items-center gap-4">
				<p class="text-center font-bold">
					Please tap your phone to proceed
					<br>
					OR
					<br>
					Contact customer service @ 1800 363 3333
				</p>
			</div>
		</Modal>
	</div>
</template>
