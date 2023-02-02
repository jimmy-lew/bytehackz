export class Command implements ISearchable {
	static id = 0
	_id: number
	command: string
	alias: string
	searchOptions = { type: 'command' } as const

	constructor(command: string, alias: string) {
		this._id = Command.id
		Command.id++
		this.command = command
		this.alias = alias
	}

	async execute(..._args: any[]) {
		throw new Error('Method not implemented.')
	}
}
