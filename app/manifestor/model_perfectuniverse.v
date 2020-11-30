module perfectuniverse

//the state how you want the universe to be

struct RetryPolicy
	name "default"
	retry []int = [1,1,1,1,10,30,60,90,180,300,300,300,600,600,600,600,600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600]


struct WishList {
	name = ""
	startwish = Wish
	retry_policies = []RetryPolicy
}

struct Wish {
	//name of the wish, what do you want the system to be, each wish needs to have a unique name
	name	string
	// we need to know the category because this defines which wish type to load e.g. install a package, or apply a network config, ...
	category CategoryEnum
	//a system to allow us to search for wishes, its free style catergorization
	tags []string
	retrypolicy_name string = "default" 	
	//name of other perfect wishes we depend on, this wish will not be executed before dependencies are ok 
	dependencies []string	
	pub mut:
		//what is the last known state when we did a last check
		state StateEnum
		//last time we checked dependencies
		check_last int
		//how often do you want to check the dependencies on changes
		check_period int	
}

pub enum StateEnum { unknown ok error }
pub enum CategoryEnum { package gitrepo app docker kubernetes network }
