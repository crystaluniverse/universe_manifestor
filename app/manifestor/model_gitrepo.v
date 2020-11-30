module manifestor

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


