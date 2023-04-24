import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class AuthService  {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signIn(String email, String password, BuildContext context) async {
     UserCredential authResult;
    try{
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e){
      log(e.code);
      String title = 'Unknown Error' ;
      String content = "Please try again later";
      switch(e.code){
         case "user-not-found":
           title = "User Not found";
           content = "Please check your email";
           break;
        case "network-request-failed":
          title = 'network request failed';
          content = "Please check internet connection";
          break;
        case "wrong-password":
          title = 'Invalid Password';
          content = "Please check Password and try again";
          break;
        default:
          break;

       }
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Ok"))
        ],
      ));

     }
    return null;

  }

  Future<User? > signUp(String email, String password) async {
    try{
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    }catch(e){
      log(e.toString());
      return null;
    }

  }

  void signOut(BuildContext context) {
     _auth.signOut().then((value) => {
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(
           builder: (BuildContext context) => const Login(),
         ),
       )
     });
  }

  Future<String?> getUserId() async {
    return _auth.currentUser?.uid;
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

}
