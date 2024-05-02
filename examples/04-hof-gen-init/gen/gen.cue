package gen

import (
	"github.com/hofstadter-io/hof/schema/gen"

	"example.com/foo/schema"
)

// This is your reusable generator module
Generator: gen.Generator & {

	//
	// user input fields
	//

	// this is the interface for this generator module
	// typically you enforce schema(s) here
	Data: {
		App: schema.App
	}
	// Input: #Input

	//
	// Internal Fields
	//

	// This is the global input data the templates will see
	// You can reshape and transform the user inputs
	// While we put it under internal, you can expose In
	// or you can omit In and skip having a global context
	In: {
		APP: Data.App
	}

	// required for hof CUE modules to work
	// your users do not set or see this field
	ModuleName: string | *"example.com/foo"

	// The final list of files for hof to generate
	// fill this with file values
	Out: [...gen.#File] & [
				 if In.APP.Readme {
					 TemplatePath: "README"
					 Filepath: "README"
				 },
	]

	// you can create any intermediate values you need internally

	// open, so your users can build on this
	...
}
