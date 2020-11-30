module application
import os
import json

pub enum PlatformType { unknown osx ubuntu alpine }

struct ApplicationData {
	pub mut:
		platform 	PlatformType
		todo		TodoData		
}

struct GitRepo {
	name	string
	url		string
	path 	string
}

fn application_path_get() string {
	return os.getenv('HOME') + '/.config/v/appstate.json'
}

pub fn (mut conf ApplicationData) load() {	
	fpath := application_path_get(conf)
    configdata := os.read_file(fpath) or {return}
    conf2 := json.decode(Application, configdata) or {
        panic('Failed to parse json for $fpath')
    }
	conf.platform = conf2.platform
    // for lang in languages_arr {
    //     l.m[lang.ext] = lang
    // }
}

pub fn (mut conf ApplicationData) save() {	
	fpath := application_path_get(conf)
	os.write_file(fpath,json.encode(conf))	
}

pub fn (mut conf ApplicationData) reset() {	
	os.rmdir_all(os.getenv('HOME') + '/.config/v/')
}

pub fn get() ApplicationData{
	os.mkdir_all(os.getenv('HOME') + '/.config/v/done')
	mut appdata := ApplicationData{}
	appdata.todo = todo_get("local")
	appdata.load()
	return appdata
}

