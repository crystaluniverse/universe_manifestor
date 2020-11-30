module manifestor
import application

// is e.g. an ubuntu packagedapp, it needs to be packaged by the package maintainers !

pub struct Package {
    name        	 string
	aliases			[]PackageAlias
}

//if there is an exception of how package needs to be installed (alias)
// e.g. on ubuntu something is called myapp but on alpine its my_app
pub struct PackageAlias {
    name        	 string
	platformtype     application.PlatformType
}

//get the right name depending the platform type
pub fn (mut package PackageAlias) name_get(platformtype application.PlatformType) {

	for alias in package.aliases {
		if alias.platformtype == platformtype {
			return alias.name
		}
	}
	return package.name
}

