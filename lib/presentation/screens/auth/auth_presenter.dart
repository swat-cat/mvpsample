import 'package:flutter/material.dart';
import 'auth_contract.dart';
import 'signin.dart';
import 'package:mvpsample/presentation/base/loading_state_properties.dart';
import 'package:mvpsample/presentation/base/strings.dart' as Strings;

class AuthPresenterImpl extends AuthPresenter {

  SignInState state;
  AuthView authView;

  AuthPresenterImpl(this.authView);

  @override
  VoidCallback initView(SignInState state) => (){
    this.state = state;
    state.properties.title = getLabel();
    state.properties.isLoading = false;
    state.properties.label = getLabel();
    state.properties.reverseLabel = getReverseLabel();
    state.properties.message = message();
    authView.toggleCallback = toggle;
    authView.confirmCallback = confirm;
  };

  void reState(VoidCallback callback){
    state.setState(callback);
  }

  @override
  void toggle(){
    reState((){
      state.properties.signState = state.properties.signState == SignState.SIGNIN?SignState.SIGNUP:SignState.SIGNIN;
      state.properties.title = getLabel();
      state.properties.label = getLabel();
      state.properties.reverseLabel = getReverseLabel();
      state.properties.message = message();
    });
  }

  @override
  void confirm(){
    if(!isInputsValid())return;
    reState(()=>state.properties.isLoading = true);
    authView.emailController.clear();
    authView.passController.clear();
    authView.confirmPassController.clear();
    authView.showInfoPopup("SignIn");
    reState(()=>state.properties.isLoading = false);
  }

  bool isInputsValid(){
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var email = authView.emailController.text.trim();
    RegExp exp = new RegExp(p);
    if(!exp.hasMatch(email)){
      authView.showInfoPopup(Strings.emailError);
      return false;
    }
    var pass = authView.passController.text;
    if(pass.length<6){
      authView.showInfoPopup(Strings.passError);
      return false;
    }
    var confirmPass = authView.confirmPassController.text;
    if(state.properties.signState == SignState.SIGNUP){
      if(confirmPass != pass){
        authView.showInfoPopup(Strings.confirmPassError);
        return false;
      }
    }
    return true;
  }

  String getLabel(){
    return state.properties.signState == SignState.SIGNIN?Strings.signin:Strings.signup;
  }

  String getReverseLabel(){
    return state.properties.signState == SignState.SIGNUP?Strings.signin:Strings.signup;
  }

  String message(){
    return state.properties.signState == SignState.SIGNIN?Strings.haveNoAccount:Strings.alreadyHaveAccount;
  }

}


class AuthStateProperties extends LoadingStateProperties{

  SignState _signState = SignState.SIGNIN;
  String _label;
  String _reverseLabel;
  String _message;
  bool _isLoading;

  SignState get signState => _signState;
  set signState(SignState value) {
    _signState = value;
  }

  String get label => _label;
  set label(String value) {
    _label = value;
  }

  String get reverseLabel => _reverseLabel;
  set reverseLabel(String value) {
    _reverseLabel = value;
  }


  String get message => _message;

  set message(String value) {
    _message = value;
  }

  @override
  set hasUser(bool value) {

  }

  @override
  set isLoading(bool value) {
    _isLoading = value;
  }

  @override
  bool get isLoading => _isLoading;

  String get title => label;

  set title(String value) {
    label = value;
  }


}