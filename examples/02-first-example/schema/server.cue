package schema

import "strings"

HTTPMethod: "OPTIONS" | "HEAD" |
	"GET" | "POST" | "PATCH" | "PUT" | "DELETE" |
	"CONNECT" | "TRACE"

Server: {
	// Most schemas have a name field
	Name: string

	// Some more common "optional" fields
	// we use defaults rather than CUE optional syntax
	Description: string | *""
	Help:        string | *""

	// The project's git repo
	GitRepo: string | *""

	// language fields
	GoModule: string

	// The server routes
	Routes: Routes

	// list of file globs to be embedded into the server when built
	EmbedGlobs: [...string]

	// enable prometheus metrics
	Prometheus: bool

	// auth settings (optional)
	Auth?: {
		apikey: bool | *false
		basic:  bool | *false
	}

	// various casings of the server Name
	serverName:  strings.ToCamel(Name)
	ServerName:  strings.ToTitle(Name)
	SERVER_NAME: strings.ToUpper(Name)
}

Routes: [...Route] | *[]
Route: {
	Name:   string
	Path:   string
	Method: HTTPMethod

	// Route and Query params
	Params: [...string] | *[]
	Query: [...string] | *[]

	// Fields which allow the user to write
	// handler bodies directly in CUE
	Body?: string
	Imports: [...string] | *[]

	// Allows subroutes for routes
	Routes: [...Route]
}
