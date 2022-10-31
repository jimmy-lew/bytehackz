<template>
    <div class="w-5/8 p-12 shadow-right-md">
        <h1 class="text-3xl whitespace-pre-line mt-8 mb-16 h-10">
            Hello!<br>
            What would you like to do today?
        </h1>
        <h2 class="font-semibold text-lg mb-8">Get Cash</h2>
        <ul class="grid grid-cols-2 gap-4 mb-4">
            <button class="btn btn-lg text-2xl leading-0 py-8 bg-gradient-to-tr from-gray-700 to-black">$50</button>
            <button class="btn btn-lg text-2xl leading-0 py-8 bg-gradient-to-tr from-gray-700 to-black">$80</button>
            <button class="btn btn-lg text-2xl leading-0 py-8 bg-gradient-to-tr from-gray-700 to-black">$100</button>
            <button class="btn btn-lg text-2xl leading-0 py-8 bg-gradient-to-tr from-gray-700 to-black">$500</button>
        </ul>
        <button class="btn btn-lg text-lg leading-0 py-8 bg-gradient-to-tr from-gray-700 to-black w-full">Other amounts</button>
    </div>
    <div class="w-3/8 p-8">
        <div class="inline-flex w-full justify-end h-fit items-center mb-28 mr-4">
            <Icon size="24" name="heroicons:language-20-solid"/> 
            <div class="divider divider-horizontal"></div>		
            <div class="flex flex-col items-center text-xs">
                <Icon size="24" name="heroicons:arrow-right-on-rectangle-20-solid"/> 
                <p class="text-gray-400">
                    Exit		
                </p>		
            </div>	
        </div>
        <h2 class="font-semibold text-lg mb-8">Non cash services</h2>
        <ul class="grid grid-cols-2 gap-4 mb-6">
            <LinkCard :title="'Activate \n Card'" :href="''">
                <Icon size="32" name="heroicons:credit-card"/>
            </LinkCard>
            <LinkCard :title="'Balance \n Enquiry'" :href="''">
                <Icon size="32" name="heroicons:currency-dollar"/>
            </LinkCard>
        </ul>
        <a href="/services" class="link link-hover link-accent inline-flex w-full justify-end">
            More services >
        </a>
    </div>
</template>