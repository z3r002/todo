import 'package:flutter/material.dart';
import 'package:todo/theme.dart';
import 'package:provider/provider.dart';


class ChangeTheme extends StatefulWidget{
  ChangeTheme({Key key, this.title}): super(key: key);
  final String title;
  @override
  MyState createState() => new MyState();

}


class MyState extends State<ChangeTheme>{
  bool val = true;
  String message = "смена темы";


  @override
  Widget build(BuildContext context){

    return new Scaffold(
        appBar: AppBar(
        title: Text('Настройки'),
        ),
        body: Container(
      child: Column(
        children: <Widget>[
         new Switch(
           value: val,
           onChanged: (bool e) => something(e),
           activeColor: Colors.green
          ),
          new Text (message),
        ],
      ),
      ),
      );

  }

 void something(bool e) {
   ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    setState(() {
      if (e){
        _themeChanger.setTheme(ThemeData.dark());
        message = "Темнаяя тема";
        val = e;
      } else {
        _themeChanger.setTheme(ThemeData.light());
        message = "Светлая тема";
        val = e;
      }
    });
 }


}


//class ChangeTheme extends StatelessWidget{
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
