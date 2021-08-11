import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginauthbloc/bloc/authMethods.dart';
import 'package:loginauthbloc/screens/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () async {
                print(_auth.currentUser?.uid);
                await EmailSignIn().signOut().then((value) =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => LoginScreen())));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Succesfull logged in"),
        ),
      ),
    );
  }
}
