<script setup lang="ts">
const dropdownItems = [
	{
		label: 'Profile',
		link: '/profile',
	},
	{
		label: 'Settings',
		link: '/settings',
	},
	{
		label: 'Logout',
		link: '/logout',
		hasTopBorder: true,
	},
]

const { path } = useRoute()
const pathsUnjoint = computed(() => path
	.split('/')
	.filter(p => p !== ''),
)
const pathsJoint = computed(() => pathsUnjoint.value
	.reduce((arr: string[], path: string, index: number) => index === 0 ? [path] : [...arr, `${arr[index - 1]}/${path}`], []),
)
</script>

<template>
	<nav class="px-6 sm:px-12 lg:px-16 border-b border-gray-200">
		<div class="flex items-center min-h-[4rem] max-w-7xl w-full mx-auto pt-6 pb-4 px-2">
			<div class="inline-flex w-1/2 justify-start items-center">
				<div class="w-8 h-8 rounded-full relative mr-2 aspect-square">
					<img src="/favicon.svg" alt="">
				</div>
				<Breadcrumbs class="pl-2">
					<BreadcrumbsItem link="/">
						Home
					</BreadcrumbsItem>
					<BreadcrumbsItem v-for="(link, index) in pathsJoint" :key="link" :link="`/${link}`">
						{{ `${pathsUnjoint[index].charAt(0).toUpperCase()}${pathsUnjoint[index].slice(1)}` }}
					</BreadcrumbsItem>
				</Breadcrumbs>
			</div>
			<div class="inline-flex w-1/2 justify-end">
				<Dropdown :items="dropdownItems">
					<template #trigger>
						<div class="w-8 h-8 rounded-full relative bg-gray-300" />
					</template>
					<template #items>
						<LazyDropdownItem
							v-for="item in dropdownItems"
							:key="item.label"
							v-bind="item"
						/>
						<li class="flex items-center p-1 border-t">
							<div class="py-2 px-4 text-sm">
								Theme Switch
							</div>
						</li>
					</template>
				</Dropdown>
			</div>
		</div>
		<Tabs class="-mb-px max-w-7xl">
			<TabsItem link="/">
				Home
			</TabsItem>
			<TabsItem link="/dashboard">
				Dashboard
			</TabsItem>
		</Tabs>
	</nav>
</template>

<style scoped>

</style>
