//can create a perfect universe using ssh only as remote execution mechanism

module manifestor

pub fn get(app application.ApplicationData) Builder{
	mut builder := Builder{app: app}
	builder.platform_load()
	return builder
}
