import 'package:flutter/material.dart';
import 'signin.dart';
import 'auth_presenter.dart';

abstract class AuthView{

  Widget buildContent();
  void showInfoPopup(String message);

  TextEditingController get emailController;
  TextEditingController get passController;
  TextEditingController get confirmPassController;

  set toggleCallback(VoidCallback value);
  set confirmCallback(VoidCallback value);
  set properties(AuthStateProperties value);
}

abstract class AuthPresenter{
  VoidCallback initView(SignInState state);
  void toggle();
  void confirm();
}