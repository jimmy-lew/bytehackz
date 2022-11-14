<script setup lang="ts">
import { collection, doc, limitToLast, onSnapshot, orderBy, query } from 'firebase/firestore'

const q = query(collection(firestoreDb, 'atm'), orderBy('timeCreated'), limitToLast(1))

onSnapshot(q, (snapshot) => {
	snapshot.forEach((doc) => {
		const { isValidated } = doc.data()
		if (isValidated)
			navigateTo('/auth/biometrics')
	})
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
