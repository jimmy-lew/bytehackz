<script setup lang="ts">

</script>

<template>
	<div class="p-12 relative w-full space-y-8">
        <Header username="Jimmy Lew"/>
		<Banner>
			<Icon size="24" name="maki:caution" />
			<span>Warning: This could be a scam!</span>
		</Banner>
		<div class="flex">
			<div class="flex w-1/2 gap-8">
				<LinkCard title="Withdrawal" href="/">
					<Icon size="36" name="fluent:money-hand-24-regular" class="" />
				</LinkCard>
				<ul class="flex flex-col gap-8">
					<LinkCard title="Payment" href="/">
						<Icon size="36" name="fa6-solid:file-signature" class="" />
					</LinkCard>
					<LinkCard title="Transfer" href="/">
						<Icon size="36" name="heroicons:arrows-right-left-20-solid" />
					</LinkCard>
				</ul>
			</div>
			<div class="flex w-1/2 gap-8 justify-end">
				<LinkCard title="More" href="/services">
					<Icon size="32" name="heroicons-solid:dots-horizontal" class="" />
				</LinkCard>
			</div>
		</div>
	</div>
    <Modal>
		Test
	</Modal>
</template>
