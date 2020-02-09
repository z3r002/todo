import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/theme.dart';
import 'package:provider/provider.dart';



class ChangeTheme extends StatefulWidget {
  ChangeTheme({Key key, this.title}) : super(key: key);
  final String title;
  @override
  MyState createState() => new MyState();
}

class MyState extends State<ChangeTheme> {
  var _darkTheme = true;
  String message = "смена темы";
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {

    final themeChanger = Provider.of<ThemeChanger>(context);
    _darkTheme = (themeChanger.getTheme() == ThemeData.dark());
    return new Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new Switch(
              value: _darkTheme,
              onChanged: (val) {
                setState(() {
                  _darkTheme = val;
                });
                onThemeChanged(val, themeChanger);
              },
            ),
            new Text(message),
          ],
        ),
      ),
    );
  }

  void onThemeChanged(bool value, ThemeChanger themeChanger) async {
    (value)
        ? themeChanger.setTheme(ThemeData.dark())
        : themeChanger.setTheme(ThemeData.light());
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }


}



//class th extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
//    return new Scaffold(
//      appBar: AppBar(
//        title: Text('настройки'),
//      ),
//      body: Container(
//        child: Column(
//          children: <Widget>[
//            FlatButton(
//                child: Text('Темная тема'),
//                onPressed: () => _themeChanger.setTheme(ThemeData.dark())),
//            FlatButton(
//                child: Text('Светлая Тема'),
//                onPressed: () => _themeChanger.setTheme(ThemeData.light()))
//
//          ],
//
//
//        ),
//        ),
//      );
//  }
//}
