export const usePath = () => useState('path', () => {
	const path = useRoute().path

	return path
})
