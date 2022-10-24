<script setup lang="ts">
    import { vOnClickOutside } from '@vueuse/components'

    const { hasCloseButton } = withDefaults(defineProps<{
        hasCloseButton?: boolean
    }>(), {
        hasCloseButton: true
    });

    const isOpen = ref(true);

    const close = () => {
        isOpen.value = false;
    }
</script>

<template>
    <div v-if="isOpen" class="modal modal-open">
        <div class="modal-box rounded-md relative" v-on-click-outside="close">
            <button v-if="hasCloseButton" @click="close" class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
            <slot />
        </div>
    </div>
</template>