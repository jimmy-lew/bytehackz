export default () => {
	return useState<Nullable<{
		uid: string
		displayName?: string
		photoURL?: string
		email?: string
	}>>('curr-user', () => null)
}
