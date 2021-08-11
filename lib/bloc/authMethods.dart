import 'package:firebase_auth/firebase_auth.dart';

class EmailSignIn {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(emails, passwords) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emails.toString(), password: passwords.toString());
      var firebaseUser = userCredential.user;

      print(firebaseUser);
      print("Sign In Successfull");
      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e);
      }
    }
  }

  Future register(emails, passwords) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: emails, password: passwords);
      var firebaseUser = userCredential.user;
      print(firebaseUser);
      print("Registration Successfull");
      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
