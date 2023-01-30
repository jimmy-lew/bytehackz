<template>
	<div class="max-w-full overflow-x-auto py-2">
		<ul class="flex items-center whitespace-nowrap">
			<slot />
		</ul>
	</div>
</template>

<style>
ul > .breadcrumb:not(:first-child)::before {
    @apply content-['/'] mx-3 text-gray-300
}

ul > .breadcrumb:last-child {
	@apply font-medium
}
</style>
