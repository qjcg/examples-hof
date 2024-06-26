package gen

import (
	"github.com/hofstadter-io/hof/schema/gen"

	"hof.io/docs/example/schema"
)

// Generator definition
Generator: gen.Generator & {

	// User inputs to this generator
	// -----------------------------

	// The server design conforming to the server schema
	Server: schema.Server

	// Base output directory, defaults to current
	Outdir: string | *"./"

	// In & Out fields for hof
	// ------------------------

	// In is passed to every template as the root keys
	In: {
		// a convention for making root keys stand out visually
		SERVER: Server
	}

	// Actual files generated by hof, combined into a single list
	Out: [...gen.File] & _All

	// Everything below here is for convenience
	_All: [
		for _, F in _OnceFiles {F},
		for _, F in _RouteFiles {F},
	]

	// Note, we can omit Templates, Partials, and Statics
	// since the default values are sufficient for us

	// Internal fields for mapping Input to templates
	// ----------------------------------------------

	// Files that are generated once per server
	_OnceFiles: [...gen.File] & [
		{
			TemplatePath: "go.mod"
			Filepath:     "go.mod"
		},
		{
			TemplatePath: "server.go"
			Filepath:     "server.go"
		},
		{
			TemplatePath: "router.go"
			Filepath:     "router.go"
		},
		{
			TemplatePath: "middleware.go"
			Filepath:     "middleware.go"
		},
		// a conditional file
		if Server.Auth != _|_ {
			TemplatePath: "auth.go"
			Filepath:     "auth.go"
		},
	]

	// Routes, we create a file per route in the Server
	_RouteFiles: [...gen.File] & [
		for _, R in Server.Routes {
			In: {
				ROUTE: {
					R
				}
			}
			TemplatePath: "route.go"
			Filepath:     "routes/\(In.ROUTE.Name).go"
		},
	]

	// We'll see how to handle nested routes and resources in upcoming sections
}
