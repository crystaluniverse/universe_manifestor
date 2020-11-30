import application
import executors

mut app := application.get()
mut executor := executors.get(app)

e := executor.exec("ls /s") or {println("Could not list this. \n$err") exit(1)}
println(e)

// println(app)
// println(executor.cmd_exists_check("lsss"))
// println(executor.exec_ok("ls /"))

// mymodule.say_hi()

// numbers := [1, 2, 3, 4, 5]
// for num in numbers {
// 	if num == 2 {
// 		println(num)
// 	}
    
// }

// executor.package_install(name:"mc")

println(app)

app.save()


app.todo.reset()
app.todo.done["re"]=true

app.todo.save()
// application.todo_save(todo)

println(app.todo)


