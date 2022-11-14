<script setup lang="ts">
import { collection, doc, limitToLast, onSnapshot, orderBy, query } from 'firebase/firestore'

const q = query(collection(firestoreDb, 'atm'), orderBy('timeCreated'), limitToLast(1))

onSnapshot(q, (snapshot) => {
	snapshot.forEach((doc) => {
		const { isBioValidated } = doc.data()
		if (isBioValidated)
			navigateTo('/services')
	})
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
