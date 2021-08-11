import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loginauthbloc/bloc/authMethods.dart';
import 'package:loginauthbloc/bloc/mixinValidattors.dart';
import 'package:loginauthbloc/screens/loginScreen.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with ValidatorsofFields {
  final _name = BehaviorSubject<String>();
  final _emailId = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get emailId => _emailId.stream.transform(emailValidator);
  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(phoneValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(confirmPasswordValidator);

  Stream<bool> get isValid => Rx.combineLatest5(name, emailId, phoneNumber,
      password, confirmPassword, (name, email, phone, pass, confPass) => true);

  Stream<bool> get passwordMatch =>
      Rx.combineLatest2(password, confirmPassword, (pass, confPass) {
        if (pass != confPass) {
          print(pass);
          print(confPass);
          return false;
        } else {
          return true;
        }
      });

  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmailId => _emailId.sink.add;
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

  submit() async {
    if (_password.value != _confirmPassword.value) {
      _confirmPassword.sink.addError("Password doesn't match");
      return 0;
    } else {
      //TODO: CALL API for registering
      print(_name.value);
      print(_emailId.value);
      print(_phoneNumber.value);
      print(_password.value);
      print(_confirmPassword.value);
      var a = await EmailSignIn().register(_emailId.value, _password.value);

      print("working" + a.toString());
      return a;
    }
  }

//dispose
  void dispose() {
    _name.close();
    _emailId.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }
}
