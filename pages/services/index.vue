<script setup>
</script>

<template>
	<div class="flex-col w-full p-12">
		<div class="flex items-center mb-8">
			<div class="inline-flex w-1/2 justify-start">
				<h1 class="whitespace-pre-line text-2xl">
					Hello!<br>
					What would you like to do today?
				</h1>
			</div>
			<div class="inline-flex w-1/2 justify-end h-fit items-center">
				<Icon size="24" name="heroicons:language-20-solid" />
				<div class="divider divider-horizontal" />
				<div class="flex flex-col items-center text-xs">
					<Icon size="24" name="heroicons:arrow-right-on-rectangle-20-solid" />
					<p class="text-gray-400">
						Exit
					</p>
				</div>
			</div>
		</div>
		<Banner>
			<Icon size="24" name="maki:caution" />
			<span>Warning: This could be a scam!</span>
		</Banner>
		<h2 class="mb-6 font-semibold text-lg">
			Non Cash Services
		</h2>
		<ul role="list" class="grid grid-cols-3 gap-4 p-0 mb-6">
			<LinkCard :title="'Set up quick \n transaction'" href="/transaction">
				<Icon size="32" name="heroicons:bars-3-bottom-left-20-solid" />
			</LinkCard>
			<LinkCard :title="'Balance \n Enquiry'" href="">
				<Icon size="32" name="heroicons:currency-dollar" />
			</LinkCard>
			<LinkCard :title="'Bill \n Payment'" href="">
				<Icon size="32" name="heroicons:banknotes" />
			</LinkCard>
			<LinkCard :title="'Transfer \n Funds'" href="/transfer">
				<Icon size="32" name="heroicons:arrows-right-left-20-solid" />
			</LinkCard>
			<LinkCard :title="'CPF \n Services'" href="">
				<Icon size="32" name="heroicons:key" />
			</LinkCard>
			<LinkCard :title="'Investment \n Services'" href="">
				<Icon size="32" name="fe:line-chart" />
			</LinkCard>
		</ul>
	</div>
	<Modal>
		Test
	</Modal>
</template>
