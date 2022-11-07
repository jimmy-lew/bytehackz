<script setup>
</script>

<template>
	<div class="flex-col w-full p-12 space-y-8">
		<Header username="Jimmy Lew" />
		<Banner>
			<Icon size="24" name="maki:caution" />
			<span>Warning: This could be a scam!</span>
		</Banner>
		<h2 class="font-semibold text-lg">
			Non Cash Services
		</h2>
		<ul role="list" class="grid grid-cols-3 gap-4 p-0">
			<LinkCard title="Set up quick \n transaction" href="/transaction">
				<Icon size="32" name="heroicons:bars-3-bottom-left-20-solid" />
			</LinkCard>
			<LinkCard title="Balance \n Enquiry" href="">
				<Icon size="32" name="heroicons:currency-dollar" />
			</LinkCard>
			<LinkCard title="Bill \n Payment" href="">
				<Icon size="32" name="heroicons:banknotes" />
			</LinkCard>
			<LinkCard title="Transfer \n Funds" href="/transfer">
				<Icon size="32" name="heroicons:arrows-right-left-20-solid" />
			</LinkCard>
			<LinkCard title="CPF \n Services" href="">
				<Icon size="32" name="heroicons:key" />
			</LinkCard>
			<LinkCard title="Investment \n Services" href="">
				<Icon size="32" name="fe:line-chart" />
			</LinkCard>
		</ul>
	</div>
</template>
