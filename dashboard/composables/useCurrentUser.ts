export default () => {
	return useState<Nullable<{
		uid: string
		displayName?: Nullable<string>
		photoURL?: Nullable<string>
		email?: Nullable<string>
	}>>('curr-user', () => null)
}
