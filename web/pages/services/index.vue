<script setup lang="ts">
</script>

<template>
	<div class="p-12 relative w-full space-y-6">
		<Header username="Jimmy" />
		<Banner>
			<img src="/Banner.svg" alt="" class="h-[4.5rem] rounded object-fill w-full">
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
			<TheCashRadialMenu />
			<div class="ml-auto">
				<LinkCard title="More" href="/services/more" class="h-2/3">
					<Icon size="32" name="heroicons-solid:dots-horizontal" class="" />
				</LinkCard>
			</div>
		</div>
		<Modal>
			<img src="/Modal.svg" alt="">
		</Modal>
	</div>
</template>
