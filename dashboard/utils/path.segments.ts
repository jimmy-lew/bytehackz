export const getPathSegments = (path: string) => path
	.split('/')
	.filter(p => p !== '')
