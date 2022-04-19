import 'package:chat_app/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submitForm(
      String? email, String? password, String? userName, bool isLogin) async {
    UserCredential userCredential;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
       userCredential=  await _auth
            .signInWithEmailAndPassword(
          email: email.toString(),
          password: password.toString(),
        );
      } else {
       userCredential =  await _auth
            .createUserWithEmailAndPassword(email: email.toString(), password: password.toString());

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          "email": email,
          "userName": userName,
        });
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred,Please check your credentials';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      debugPrint("Err:- ${err}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade100, body: AuthForm(_submitForm));
  }
}
