import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginauthbloc/bloc/loginBloc.dart';
import 'package:loginauthbloc/screens/home.dart';
import 'package:loginauthbloc/screens/registerScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var blocs = LoginBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    blocs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Color(0xffFFF1F1),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _textFieldWidget(bloc.loginEmail, bloc.changeloginEmail,
                    "Enter email", "Email"),
                _textFieldWidget(bloc.loginPassword, bloc.changeLoginPassword,
                    "Enter password", "password"),
                _buildButton(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Don't have account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                        text: "Register here",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                          })
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldWidget(bloc, blocOnchange, hintText, labelText) {
    return StreamBuilder<String>(
        stream: bloc,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText:
                  hintText.toString().contains("password") ? true : false,
              decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: blocOnchange,
            ),
          );
        });
  }

  Widget _buildButton() {
    final bloc = Provider.of<LoginBloc>(context, listen: false);

    return StreamBuilder<Object>(
        stream: bloc.isValid,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: snapshot.hasError || !snapshot.hasData
                  ? Colors.grey
                  : Colors.blue,
              onPressed: snapshot.hasError || !snapshot.hasData
                  ? null
                  : () async {
                      int a = await bloc.submit();
                      a == 1
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()))
                          : null;
                    },
              child: Text("Login"),
            ),
          );
        });
  }
}
