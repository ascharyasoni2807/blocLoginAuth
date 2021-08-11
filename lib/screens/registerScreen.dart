import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginauthbloc/bloc/registerBloc.dart';
import 'package:loginauthbloc/screens/home.dart';
import 'package:loginauthbloc/screens/loginScreen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;

  var blocs = RegisterBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    blocs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

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
                  "Register User",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _textFieldWidget(
                    bloc.name, bloc.changeName, "Enter Name", "Name"),
                _textFieldWidget(
                    bloc.emailId, bloc.changeEmailId, "Enter email", "Email"),
                _textFieldWidget(bloc.phoneNumber, bloc.changePhoneNumber,
                    "Enter Phone ", "Phone"),
                _textFieldWidget(bloc.password, bloc.changePassword,
                    "Enter Password", " Password"),
                StreamBuilder<Object>(
                    stream: bloc.confirmPassword,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            labelText: "confirm pasword",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: isVisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                          ),
                          onChanged: bloc.changeConfirmPassword,
                        ),
                      );
                    }),
                _loginButton(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Already Registered?",
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(
                        text: "Login here",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
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

  Widget _loginButton() {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

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
                      var a = await bloc.submit();
                      a == 1
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()))
                          : null;
                    },
              child: Text("Register"),
            ),
          );
        });
  }
}
