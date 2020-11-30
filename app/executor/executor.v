module executor
import application
import os

pub fn (mut executor ExecutorLocal) cmd_exists_check(cmd string)bool {	
	return executor.exec_ok("which $cmd 2>&1 > /dev/null")
}

pub struct ExecutorLocal {
	pub mut:
		platform 	PlatformType
		todo		TodoData	
		name string = "local"
}

pub fn (mut executor ExecutorLocal) exec_ok(cmd string)bool {	
	e := os.exec("$cmd 2> /dev/null") or { 
		//see if it executes ok, if cmd not found is false
        return false
    }
	// println(e)
	if e.exit_code == 0 { return true } else {return false}	
}

pub fn (mut executor ExecutorLocal) exec(cmd string) ?string {	
	println(cmd)
	e := os.exec("$cmd") or { 
        return error("could not find command: $cmd")
    }
	if e.exit_code == 0 { 
		return e.output
	} else {
		return error("could not execute: $cmd\n Error was:$e")
	}
}

fn (mut executor ExecutorLocal) platform_load() {
	if executor.app.platform == application.PlatformType.unknown {
		if executor.cmd_exists_check("sw_vers") {
			executor.app.platform = application.PlatformType.osx
		} else if executor.cmd_exists_check("apt") {		
			executor.app.platform = application.PlatformType.ubuntu
		} else if executor.cmd_exists_check("apk") {		
			executor.app.platform = application.PlatformType.alpine
		} else {
			panic ("only ubuntu, alpine and osx supported for now")
		}
	}
}

pub struct PackageToInstall {
    name        	 string
    expiration_check int = 3600*24*7
    heiresetght      bool
}

pub fn (mut executor ExecutorLocal) package_install(mut package PackageToInstall) {
	name := package.name
	executor.platform_load()
	if executor.app.platform == application.PlatformType.osx {
		executor.exec("brew install $name")
	} else if executor.app.platform == application.PlatformType.ubuntu {
		executor.exec("apt install $name -y")
	} else if executor.app.platform == application.PlatformType.alpine {
		executor.exec("apk install $name")
	} else {
		panic ("only ubuntu, alpine and osx supported for now")
	}
}

pub fn get(app application.ApplicationData) ExecutorLocal{
	mut executor := ExecutorLocal{app: app}
	executor.platform_load()
	return executor
}
