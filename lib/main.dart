import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/screens/auth/signin.dart';

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MvpSample',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SignIn(),
      routes:  <String, WidgetBuilder> {
      },
    );
  }
}