module manifestor

import executor
import application

pub struct Builder {
	pub mut:
		name string = "mymachine"	
		executor 	executor.ExecutorLocal
		todo		application.TodoData	
}

pub fn (mut builder Builder) cmd_exists(cmd string)bool {	
	return builder.exec_ok("which $cmd 2>&1 > /dev/null")
}


pub fn (mut builder Builder) exec_ok(cmd string)bool {	
	e := builder.executor.exec("$cmd 2> /dev/null") or { 
		//see if it executes ok, if cmd not found is false
        return false
    }
	// println(e)
	if e.exit_code == 0 { return true } else {return false}	
}


fn (mut builder Builder) platform_load() {
	if builder.app.platform == application.PlatformType.unknown {
		if builder.cmd_exists("sw_vers") {
			builder.app.platform = application.PlatformType.osx
		} else if builder.cmd_exists("apt") {		
			builder.app.platform = application.PlatformType.ubuntu
		} else if builder.cmd_exists("apk") {		
			builder.app.platform = application.PlatformType.alpine
		} else {
			panic ("only ubuntu, alpine and osx supported for now")
		}
	}
}


pub fn (mut builder Builder) package_install(mut package Package) {
	name := package.name
	builder.platform_load()
	if builder.app.platform == application.PlatformType.osx {
		builder.exec("brew install $name")
	} else if builder.app.platform == application.PlatformType.ubuntu {
		builder.exec("apt install $name -y")
	} else if builder.app.platform == application.PlatformType.alpine {
		builder.exec("apk install $name")
	} else {
		panic ("only ubuntu, alpine and osx supported for now")
	}
}

pub fn get(app application.ApplicationData) Builder{
	mut builder := Builder{app: app}
	builder.platform_load()
	return builder
}
