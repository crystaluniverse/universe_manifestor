module mymodule

import sync

// To export a function we have to use `pub`
fn task2(id int, duration int, mut wg sync.WaitGroup) {
	println('task $id begin')
	if id == 2 {
		println('DURATION 2')
		panic('sss')
	}
	wg.done()
}

pub fn say_hi2() {
	mut wg := sync.new_waitgroup()
	wg.add(3)
	go task2(1, 500, mut wg)
	go task2(2, 900, mut wg)
	go task2(3, 100, mut wg)
	wg.wait()
	println('done')
}
