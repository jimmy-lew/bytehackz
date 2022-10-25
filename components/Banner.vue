<script setup>
    const isOpen = ref(true);

    const close = () => {
        isOpen.value = false;
    }
</script>

<template>
    <div v-if="isOpen" class="alert alert-warning shadow-lg rounded-md mb-4">
        <div class="w-1/2">
            <slot />
        </div>
        <div class="w-1/2 inline-flex justify-end">
            <button @click="close" class="btn btn-sm btn-circle btn-ghost">✕</button>
        </div>
    </div>
</template>