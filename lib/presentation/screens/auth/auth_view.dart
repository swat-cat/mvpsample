import 'package:flutter/material.dart';
import 'auth_contract.dart';
import 'auth_presenter.dart';
import 'signin.dart';
import 'package:mvpsample/presentation/base/dialog_shower.dart' as DialogShower;

class AuthViewImpl implements AuthView{

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _confirmPassController = new TextEditingController();

  VoidCallback _confirmCallback;
  VoidCallback _toggleCallback;

  AuthStateProperties _properties;
  BuildContext context;


  AuthViewImpl(this.context);

  Widget emailTextField() => new Container(
    alignment: new Alignment(0.5, 0.5),
    height: 36.0,
    margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration:
    new BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
        border: new Border.all(color: Colors.grey)),
    child: new TextField(
      controller: _emailController,
      decoration: new InputDecoration.collapsed(hintText: "Email"),
      keyboardType: TextInputType.emailAddress,
    ),
  );

  @override
  Widget buildContent() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          emailTextField(),
          passwordTextField(),
          properties.signState == SignState.SIGNUP?confirmPassTextField():emptyView(),
          confirmButton(confirmCallback),
          messageLabel(),
          toggleSignState(toggleCallback)
        ],
      ),
    );
  }

  Widget toggleSignState(VoidCallback callback) => new FlatButton(
      onPressed: callback,
      child: new Text(
        properties.reverseLabel,
        style: new TextStyle(color: new Color(0xff64B5F6)),
      ));

  Widget messageLabel() => new Text(properties.message);

  Widget confirmButton(VoidCallback callback) => new Padding(padding: new EdgeInsets.all(8.0),
      child: new RaisedButton(
          color: new Color(0xff64B5F6),
          onPressed: callback,
          child: new Text(
            properties.label,
            style: new TextStyle(
                color: new Color(0xffffffff)
            ),
          )));

  Widget confirmPassTextField()  => new Container(
    alignment: new Alignment(0.5, 0.5),
    height: 36.0,
    margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration:
    new BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
        border: new Border.all(color: Colors.grey)),
    child: new TextField(
      obscureText: true,
      controller: _confirmPassController,
      decoration: new InputDecoration.collapsed(hintText: "Confirm password"),
    ),
  );

  Widget passwordTextField() => new Container(
    alignment: new Alignment(0.5, 0.5),
    height: 36.0,
    margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration:
    new BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
        border: new Border.all(color: Colors.grey)),
    child: new TextField(
      obscureText: true,
      controller: _passController,
      decoration: new InputDecoration.collapsed(hintText: "Password"),
    ),
  );

  Widget emptyView() => new Container();

  @override
  void showInfoPopup(String message){
    var dialog = DialogShower.buildDialog(
        message: message,
        confirm: "OK",
        confirmFn: () => Navigator.pop(context));
    showDialog(context: context, child: dialog);
  }

  TextEditingController get emailController => _emailController;

  TextEditingController get passController => _passController;

  TextEditingController get confirmPassController => _confirmPassController;


  AuthStateProperties get properties => _properties;

  set properties(AuthStateProperties value) {
    _properties = value;
  }

  set toggleCallback(VoidCallback value) {
    _toggleCallback = value;
  }

  set confirmCallback(VoidCallback value) {
    _confirmCallback = value;
  }

  VoidCallback get toggleCallback => _toggleCallback;

  VoidCallback get confirmCallback => _confirmCallback;
}