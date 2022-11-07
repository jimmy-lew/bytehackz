<script setup lang="ts">
const store = useAppStore()
</script>

<template>
	<div class="p-12 relative w-full space-y-8">
		<Header :username="store.name" />
		<Banner>
			<Icon size="24" name="maki:caution" />
			<span>Scam warning banner</span>
		</Banner>
		<div class="flex gap-8">
			<LinkCard title="Withdrawal" href="/withdraw">
				<Icon size="36" name="fluent:money-hand-24-regular" class="" />
			</LinkCard>
			<ul class="flex flex-col gap-8">
				<LinkCard title="Payment" href="/">
					<Icon size="36" name="fa6-solid:file-signature" class="" />
				</LinkCard>
				<LinkCard title="Transfer" href="/transfer">
					<Icon size="36" name="heroicons:arrows-right-left-20-solid" />
				</LinkCard>
			</ul>
			<!-- <div class="flex w-1/2 gap-8">
			</div> -->
			<TheCashRadialMenu />
			<div class="ml-auto">
				<LinkCard title="More" href="/services" class="h-2/3">
					<Icon size="32" name="heroicons-solid:dots-horizontal" class="" />
				</LinkCard>
			</div>
		</div>
		<Modal>
			Sample Scam Warning Modal
		</Modal>
	</div>
</template>
