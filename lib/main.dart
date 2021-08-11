import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginauthbloc/bloc/loginBloc.dart';
import 'package:loginauthbloc/bloc/registerBloc.dart';
import 'package:loginauthbloc/screens/home.dart';
import 'package:loginauthbloc/screens/loginScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool userIsLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    getLoggedinState();
  }

  getLoggedinState() async {
    if (_auth.currentUser != null) {
      setState(() {
        userIsLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBloc>(create: (context) => RegisterBloc())
      ],
      child: MaterialApp(
        title: 'Complete Authentication',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: userIsLoggedIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
