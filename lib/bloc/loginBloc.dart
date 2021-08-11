import 'dart:async';

import 'package:loginauthbloc/bloc/mixinValidattors.dart';
import 'package:loginauthbloc/bloc/authMethods.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with ValidatorsofFields {
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //Getters
  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(loginPasswordValidator);

  Stream<bool> get isValid =>
      Rx.combineLatest2(loginEmail, loginPassword, (loginEmail, pass) => true);

  //Setters
  Function(String) get changeloginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;

  submit() async {
    print(_loginEmail.value);
    print(_loginPassword.value);
    var a = await EmailSignIn()
        .signInWithEmailAndPassword(_loginEmail.value, _loginPassword.value);
    print("worlinh" + a.toString());
    return a;
  }

  //Dispose
  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
  }
}
