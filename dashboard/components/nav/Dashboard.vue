<!-- eslint-disable @typescript-eslint/indent -->
<script setup lang="ts">
const theme = useColorMode()
const path = usePath()

const user = useCurrentUser()
const isAuthenticated = computed(() => !!user.value)

const dropdownItems = isAuthenticated.value
	? [
		{
			label: 'Profile',
			action: () => {
				// navigateTo('/profile')
			},
		},
		{
			label: 'Settings',
			action: () => {
				navigateTo('/profile/settings')
			},
		},
		{
			label: 'Logout',
			action: () => {
				console.log('logout')
			},
			hasTopBorder: true,
		},
	]
	: [
		{
			label: 'Login',
			action: login,
		},
	]

const pathSegments = computed(() => getPathSegments(path.value))
const pathsJoint = computed(() => getJointPaths(pathSegments.value))
</script>

<template>
	<nav class="px-6 sm:px-12 lg:px-16 border-b dark:border-white/20">
		<div class="flex items-center min-h-[4rem] max-w-7xl w-full mx-auto pt-6 pb-4">
			<div class="inline-flex w-1/2 justify-start items-center">
				<div class="w-8 h-8 rounded-full relative mr-2 aspect-square">
					<img src="/favicon.svg" alt="">
				</div>
				<Breadcrumbs class="pl-2">
					<BreadcrumbsItem link="/">
						Home
					</BreadcrumbsItem>
					<BreadcrumbsItem v-for="(link, index) in pathsJoint" :key="link" :link="`/${link}`">
						{{ startingWithCapital(pathSegments[index]) }}
					</BreadcrumbsItem>
				</Breadcrumbs>
			</div>
			<div class="inline-flex w-1/2 justify-end">
				<Dropdown :items="dropdownItems">
					<template #trigger>
						<div class="w-8 h-8 rounded-full relative bg-gray-300" />
					</template>
					<template #items>
						<li class="flex items-center p-1 border-t border-[#e5e7eb] dark:border-[#3d3d3d]">
							<div class="flex items-center justify-between w-full px-4 py-0.5 text-sm">
								{{ startingWithCapital(theme.value) }}
								<MiscTheThemeToggle />
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
