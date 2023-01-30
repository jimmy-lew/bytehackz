export default defineNuxtPlugin(() => {
	const user = useCurrentUser()

	addRouteMiddleware(
		'route-guard',
		({ path }) => {
			const unprotectedRoutes = ['/login', '/tokenexpired', '/']

			// if (path === '/' && user.value) return navigateTo('/dashboard')
			// if (path === '/login' && user.value) return navigateTo('/')
			// if (!unprotectedRoutes.includes(path) && !user.value) return navigateTo('/')
		},
		{ global: true },
	)
})

// TODO: Token expiry guard
// const tokenExpired = useTokenExpiryStatus()

// if (to.path !== '/tokenexpired' && tokenExpired.value) {
//     return navigateTo({
//         path: '/tokenexpired',
//         query: {
//             redirectUrl: to.path,
//         },
//     })
// }
