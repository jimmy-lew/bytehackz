<script setup lang="ts">
    const { title, href } = defineProps<{
        title: string,
        href: string
    }>()
</script>

<template>
    <li class="card card-compact bg-white rounded-lg shadow-md transition-all ease-astro duration-300 hover:scale-105 focus:scale-105">
        <a :href="href" class="card-body text-black">
            <div class="card-actions justify-end">
                <span class="text-gray-400">
                    <slot/>			  
                </span>
            </div>
            <h2 class="card-title mt-14 whitespace-pre-line">
                {{title}}
            </h2>
        </a>
    </li>
</template>