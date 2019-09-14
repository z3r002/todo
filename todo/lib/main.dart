import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(          // Добавьте 3 строки отсюда...
          primaryColor: Colors.black,
        ),                             // ... до сюда.
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

  List<String> _todoItems = [];



  @override
  Widget build(BuildContext context) {
    _getPrefs();
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List'),
      actions: <Widget>[
      PopupMenuButton<String>(
       onSelected: choiceAction ,
        itemBuilder: (BuildContext context){
         return Constants.choices.map((String choice){
            return PopupMenuItem<String>(
            value: choice,
              child: Text(choice),
            );
         }).toList();
        },
      )
      ]),
      body: _buildTodoList(),

      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.black,
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
 void choiceAction(String choice){
    if (choice == Constants.ChangeTheme){
      _changeTheme();


    } else if (choice == Constants.OffAd){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
                title: new Text('Хочешь отключить рекламу?\n\n'
                    'Разработчку и дизайнеру тоже хочеца кушатб, '
                    'поэтому для отключения рекламы отправь деняк. '),
                actions: <Widget>[
                  new FlatButton(
                      child: new Text('подробнее'),
                      onPressed: () => Navigator.of(context).pop()),
                  new FlatButton(
                      child: new Text('нет я жмот'),
                      onPressed: () => Navigator.of(context).pop()),
                ]);
          });


    } else if (choice == Constants.info){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
                title: new Text('Todo\n'
                                'Разбработчик: motiktoliika@gmail.com \n'
                                'Дизайнер: misha_k_2018@mail.ru \n'
                                ),



                actions: <Widget>[
                  new FlatButton(
                      child: new Text('оценить'),
                      onPressed: () => Navigator.of(context).pop()),
                  new FlatButton(
                      child: new Text('отмена'),
                      onPressed: () => Navigator.of(context).pop()),
                ]);
          });

    }
 }

 void _changeTheme(){
   Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
     return new Scaffold(
         appBar: new AppBar(title: new Text('Тема')),
         body: Text('тут будут темы, ожидайте...'));
   }));
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