import 'package:flutter/material.dart';
import '../../base/loading_state.dart';
import 'auth_presenter.dart';
import 'auth_view.dart';
import 'auth_contract.dart';

class SignIn extends StatefulWidget {
  @override
  State createState() => new SignInState();
}

class SignInState extends LoadingBaseState<SignIn> {

  AuthView view;
  AuthPresenter presenter;

  AuthStateProperties properties;

  @override
  void initState() {
    super.initState();
    properties = new AuthStateProperties();
    view = new AuthViewImpl(context);
    view.properties = properties;
    presenter = new AuthPresenterImpl(view);
    presenter.initView(this)();
  }

  @override
  Widget content(){
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          view.buildContent()
        ],
      ),
    );
  }

  @override
  isLoading() {
    return properties.isLoading;
  }

  @override
  String title() {
    return properties.title;
  }


}

enum SignState{
  SIGNIN,SIGNUP
}