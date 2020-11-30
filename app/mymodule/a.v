module mymodule

import sync
import time
import log
import os

fn task(id int, duration int, mut wg sync.WaitGroup) {
	mut l := log.Log{}
	l.set_level(.debug)
	// l.fatal("this is fatal error1")
	l.info('debug message $id')
	println('task $id begin')
	time.sleep_ms(duration)
	println('task $id end')
	// next directory does not exist
	e := os.exec('ls /') or {
		panic(err)
	}
	if e.exit_code != 0 {
		println(e)
		l.fatal('this is fatal error \n' + e.output)
	}
	println(e.output)
	wg.done()
}

pub fn say_hi() {
	// ls('/s') or { panic(err) }
	mut wg := sync.new_waitgroup()
	wg.add(3)
	go task(1, 500, mut wg)
	go task(2, 900, mut wg)
	go task(3, 100, mut wg)
	wg.wait()
	println('done')
}
