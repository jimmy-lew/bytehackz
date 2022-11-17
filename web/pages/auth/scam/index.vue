<script setup lang="ts">
import { doc, onSnapshot, updateDoc } from 'firebase/firestore'

const docID = useCookie('doc_id').value

onSnapshot(doc(firestoreDb, 'atms/000001/sessions', docID), async (doc) => {
	if (!doc.exists())
		return
	const { appScore } = doc.data()
	if (appScore > 0) {
		const scs = parseFloat(useCookie('SCS').value)
		const overallScore = (scs + appScore) / 2

		await updateDoc(doc.ref, {
			overallScore,
		})

		if (overallScore > 0.7) {
			await navigateTo('/auth/scam/detected')
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
				<img src="/tapphone.gif" alt="" class="w-16 h-16">
				<p class="text-center font-semibold">
					Please tap your phone to proceed
					<br>
					<span class="font-bold">OR</span>
					<br>
					Contact customer service
					<br>
					@ 1800 363 3333
				</p>
			</div>
		</Modal>
	</div>
</template>
