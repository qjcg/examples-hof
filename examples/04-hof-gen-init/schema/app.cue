package schema

App: {
	Name!: string

	Benthos: bool | *false
	Makefile: bool | *false
	Readme: bool | *true
	Taskfile: bool | *true
}
