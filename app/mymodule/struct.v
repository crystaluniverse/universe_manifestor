module mymodule

import json

// import x.json2
struct ContactItem {
	mut:
		description string
		telnr       string
		yes			bool
		nr			int
}

struct User {
	mut:
		name     string
		age      int
		// contact1 struct ContactItem [skip]
		contact2 ContactItem
}

pub fn json_test() {
	data := '{ 
				"name": "Frodo", 
				"age": 25,
				"contact2": {
					"description": "descr",
					"telnr": "+32333",
					"yes": true
				}
			}'

	// user := json2.raw_decode(data){
	// 	println("s")
	// }
	// person := user.as_map()
	mut user := json.decode(User, data) or {
		eprintln('Failed to decode json')
		eprintln(err)
		return
	}

	user.contact2.description="s"

	println(user)

	data2 := json.encode( user)

	println(data2)

}

// println(user.name)
// println(user.last_name)
// println(user.age)
// // You can also decode JSON arrays:
// sfoos := '[{"x":123},{"x":456}]'
// foos := json.decode([]Foo, sfoos)?
// println(foos[0].x)
// println(foos[1].x)
