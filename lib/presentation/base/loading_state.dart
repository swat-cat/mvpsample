import 'package:flutter/material.dart';


abstract class LoadingBaseState<T extends StatefulWidget> extends State<T> {

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
        title: new Text(title()),
    ),
    body: isLoading()?new Center(
      child: new CircularProgressIndicator(),
    ):content(),
  );

  Widget content();

  String title();

  bool isLoading();

}