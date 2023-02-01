export default () => {
	return useState('last-updated', () => new Date())
}
