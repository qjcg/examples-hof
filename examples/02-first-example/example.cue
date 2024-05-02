package example

import (
	"hof.io/docs/example/gen"
)

// This is example usage of your generator
Example: gen.Generator & {
	@gen(example)

	// inputs to the generator
	Data: {...}
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
