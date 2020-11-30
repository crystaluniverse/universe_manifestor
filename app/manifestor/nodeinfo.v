module nodeinfo

import json

// THE OBJECT TO KEEP STATE FOR ANY NODE
pub enum PlatformType { unknown osx ubuntu alpine }
struct NodeInfo {
	//the unique identifier of the nodeinfo object
	key string
	pub mut:
		//to see what was already done and what not
		done map[string]bool
		platform 	PlatformType
		gitrepos map[string]GitRepo
}

struct GitRepo {
	name	string
	url		string
	pub mut:
		required GitRepoRequired
		state GitRepoState
	lastpull int
	gitstate GitState

}
pub enum GitRepoActionEnum { nothing commit pull push reset delete}
struct GitRepoRequired {
	pub mut:
		nextaction GitRepoActionEnum
		//only relevant for when doing commit
		commitmesssage string	
		//max period in sec before commit, pull or push needs to happen, default 0, means will not check
		period_commit int
		period_pull int
		period_push int
}
pub enum GitRepoStateEnum { unknown uptodate changes error }
struct GitRepoState {
	path 	string
	//last time we checked commit, pull or push
	last_commit int
	last_pull int
	last_push int
	state GitRepoStateEnum
	branch string
}


fn state_path_get(nodeinfo NodeInfo) string {
	return os.getenv('HOME') + '/.config/v/done/${nodeinfo.key}.json'
}

pub fn (mut nodeinfo NodeInfo) load() {	

	fpath := state_path_get(nodeinfo)
    statedata := os.read_file(fpath) or {
		nodeinfo.done = map[string]bool
		platform = PlatformType.unknown
        return
    }
    conf2 := json.decode(NodeInfo, statedata) or {
        panic('Failed to parse json for $fpath.\n Data was $statedata')
    }
	//why do we have to repeat this
	// nodeinfo.done = conf2.done
	// nodeinfo.platform = conf2.platform
}

pub fn (mut nodeinfo NodeInfo) reset() {	
	fpath := state_path_get(nodeinfo)
	os.rm(fpath)
	nodeinfo.load()
}

pub fn (mut nodeinfo NodeInfo) save() {	
	fpath := state_path_get(nodeinfo)
	os.write_file(fpath,json.encode(nodeinfo))	
}

// pub fn (mut nodeinfo NodeInfo) check(name string) {	
// 	nodeinfo.
// }

pub fn get(key string) NodeInfo{
	mut data := NodeInfo{key: key}
	data.load()
	return data
}
