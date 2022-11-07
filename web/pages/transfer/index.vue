<script setup lang="ts">
const router = useRouter()

const handleClick = (accNo: string) => router.push({
	path: `/transfer/${accNo}`,
})
</script>

<template>
	<div class="flex flex-col relative p-12 w-full ease-astro">
		<!-- <Header username="Test" /> -->
		<div class="flex flex-col justify-center items-center w-full h-full space-y-16">
			<h1 class="text-3xl font-medium">
				Please select an account to access
			</h1>
			<div class="flex justify-evenly items-center w-full">
				<BaseCard round="lg" size="8" class="font-medium" @click="() => handleClick('100-000000-0')">
					<div class="flex flex-col items-center justify-center text-xl">
						<Icon size="48" name="fluent:vault-16-regular" />
						Current Account
						<div class="flex flex-col items-center justify-center text-xs mt-2">
							100-000000-0
							<span class="text-gray-400">
								Singapore Dollar
							</span>
						</div>
					</div>
				</BaseCard>
				<BaseCard round="lg" size="8" class="font-medium" @click="() => handleClick('200-000000-0')">
					<div class="flex flex-col items-center justify-center text-xl">
						<Icon size="48" name="fluent:savings-16-regular" />
						Savings Account
						<div class="flex flex-col items-center justify-center text-xs mt-2">
							200-000000-0
							<span class="text-gray-400">
								Singapore Dollar
							</span>
						</div>
					</div>
				</BaseCard>
			</div>
		</div>
	</div>
</template>
