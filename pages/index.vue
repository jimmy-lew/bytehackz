<template>
    <div class="p-12 relative w-full space-y-8">
        <div class="flex items-center">
            <div class="inline-flex w-1/2 justify-start">
                <h1 class="whitespace-pre-line text-2xl">
                    Welcome! Jimmy Lew
                </h1>
            </div>
            <div class="inline-flex w-1/2 justify-end h-fit items-center">
                <Icon size="24" name="heroicons:language-20-solid"/> 
                <div class="divider divider-horizontal"></div>		
                <div class="flex flex-col items-center text-xs">
                    <Icon size="24" name="heroicons:arrow-right-on-rectangle-20-solid"/> 
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
                        <Icon size="36" name="heroicons:arrows-right-left-20-solid"/> 
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
</template>

<script setup lang="ts">

</script>    