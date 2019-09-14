import 'package:flutter/material.dart';
import 'package:todo/theme.dart';
import 'package:provider/provider.dart';


class ChangeTheme extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('Темная тема'),
              onPressed: () => _themeChanger.setTheme(ThemeData.dark())),
            FlatButton(
              child: Text('Светлая Тема'),
              onPressed: () => _themeChanger.setTheme(ThemeData.light()))

          ],
        ),
      ),
    );
  }

}