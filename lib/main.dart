import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> todos = [
    ToDo(task: 'Wake up at 6', isDone: false),
    ToDo(task: 'Drink water', isDone: false),
    ToDo(task: 'Breakfast', isDone: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('To-Do List'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: ListView(
        children: todos.map((todo) => ToDoCard(
          todo: todo,
          delete: () {
            setState(() {
              todos.remove(todo);
            });
          },
          edit: () {
            _editTask(context, todo);
          },
          toggleDone: () {
            setState(() {
              todo.isDone = !todo.isDone;
            });
          },
        )).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Add Task',
        backgroundColor: Colors.deepPurple[300],
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(labelText: 'Task'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  todos.add(ToDo(
                    task: newTask,
                    isDone: false,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editTask(BuildContext context, ToDo todo) {
    String updatedTask = todo.task;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            onChanged: (value) {
              updatedTask = value;
            },
            decoration: InputDecoration(
              labelText: 'Task',
              hintText: todo.task,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  todo.task = updatedTask;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class ToDo {
  String task;
  bool isDone;

  ToDo({
    required this.task,
    required this.isDone,
  });
}

class ToDoCard extends StatelessWidget {
  final ToDo todo;
  final Function delete;
  final Function edit;
  final Function toggleDone;

  ToDoCard({
    required this.todo,
    required this.delete,
    required this.edit,
    required this.toggleDone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Checkbox(
                  value: todo.isDone,
                  onChanged: (bool? value) {
                    toggleDone();
                  },
                ),
                Expanded(
                  child: Text(
                    todo.task,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    edit();
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                ),
                TextButton.icon(
                  onPressed: () {
                    delete();
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
