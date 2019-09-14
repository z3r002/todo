import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  String _haveStarted3Times = '';
  List<String> _todoItems = [];



  @override
  Widget build(BuildContext context) {
    _getPrefs();
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addTodoItem,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }

  Widget _buildTodoList() {
    return new ListView.builder(itemBuilder: (context, index) {
      if (index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
    });
  }









  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
        title: new Text(todoText), onTap: () => _removeTodoItem(index));
  }

  void _addTodoItem() {
    // Push this page onto the stack
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('добавление задачи')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Введите вашу задачу',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  void _addItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
      _setPrefs();
    }
  }

  void _removeTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Задача "${_todoItems[index]}" выполнена?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('отмена'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('выполнена'),
                    onPressed: () {
                      _removeItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _removeItem(int index) {
    setState(() => _todoItems.removeAt(index));
    _setPrefs();
  }

  void _setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('TodoList', _todoItems);
  }

  void _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('TodoList') != null)
      _todoItems = prefs.getStringList('TodoList');
  }
}