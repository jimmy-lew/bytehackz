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
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 21l5.25-11.25L21 21m-9-3h7.5M3 5.621a48.474 48.474 0 016-.371m0 0c1.12 0 2.233.038 3.334.114M9 5.25V3m3.334 2.364C11.176 10.658 7.69 15.08 3 17.502m9.334-12.138c.896.061 1.785.147 2.666.257m-4.589 8.495a18.023 18.023 0 01-3.827-5.802" />
            </svg>
            <div class="divider divider-horizontal"></div>		
            <div class="flex flex-col items-center text-xs">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15m3 0l3-3m0 0l-3-3m3 3H9" />
                </svg>		
                <p class="text-gray-400">
                    Exit		
                </p>		
            </div>	
        </div>
        <h2 class="font-semibold text-lg mb-8">Non cash services</h2>
        <ul class="grid grid-cols-2 gap-4 mb-6">
            <LinkCard :title="'Activate \n Card'" :href="''">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5z" />
                </svg>
            </LinkCard>
            <LinkCard :title="'Balance \n Enquiry'" :href="''">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
            </LinkCard>
        </ul>
        <a href="/services" class="link link-hover link-accent inline-flex w-full justify-end">
            More services >
        </a>
    </div>
</template>