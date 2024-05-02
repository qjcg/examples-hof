package foo

import (
	"example.com/foo/gen"
)

// This is example usage of your generator
Foo: gen.Generator & {
	@gen(foo)

	// inputs to the generator
	Data: {
		App: {
			Name: "AwesomeApp"
		}
	}
	Outdir: "./out/"

	// File globs to watch and trigger regen when changed
	// Normally, a user would set this to their designs / datamodel
	WatchFull: [...string]
	// This is helpful when authoring generator modules
	WatchFast: [...string]

	// required by examples inside the same module
	// your users do not set or see this field
	ModuleName: ""
}
