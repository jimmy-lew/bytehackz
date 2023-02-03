export default defineNuxtRouteMiddleware((to) => {
	const path = usePath()
	path.value = to.path
})
