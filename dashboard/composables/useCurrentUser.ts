export default () => {
	return useState<Nullable<{
		uid: string
		email?: Nullable<string>
	}>>('curr-user', () => null)
}
