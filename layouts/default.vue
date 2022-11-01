<script setup>
// const colorMode = useColorMode()
// colorMode.preference = 'dark'
</script>

<template>
	<div class="w-screen h-screen bg-white dark:bg-base-content">
		<main class="m-auto p-12 max-w-5xl h-full flex justify-center">
			<div id="main" class="h-full w-full rounded-xl flex relative bg-base-100">
				<slot />
			</div>
		</main>
	</div>
</template>

<style global>
:root {
    --rgb :   0, 225, 244;
    --rgb2: 194,  97, 254;
}

.glass-outline::before {
    @apply content-default p-px absolute inset-0;
    border-radius: inherit;
    background: linear-gradient(rgba(255, 255, 255, .1), rgba(255, 255, 255, 0) 120%);
    mask: linear-gradient(black, black) content-box content-box, linear-gradient(black, black);
    -webkit-mask-composite: xor;
}
.glass-outline {
    background: radial-gradient(ellipse at center,rgba(var(--rgb2), 0.15), rgba(255, 255, 255 ,0))
}

/* rgba(169,130,216, .6) */

html[data-theme="light"] .glass-outline::before {
    background: linear-gradient(to bottom left, rgba(160,160,160, .3), rgba(255, 255, 255, 0) 120%);
    mask: linear-gradient(white, white) content-box content-box, linear-gradient(white, white);
}
html[data-theme="light"] .glass-outline {
    background: none;
}
</style>

<style scoped>
#main::before {
    @apply content-default absolute inset-0;
    background: radial-gradient(ellipse 100% 40% at 50% 50%, rgba(var(--rgb), .1),rgba(255, 255, 255, 0));
}

html[data-theme="light"] #main::before {
    @apply hidden
}
</style>
