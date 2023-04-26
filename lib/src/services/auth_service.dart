
import 'package:dear_diary/src/dto/auth_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<AuthDto> signIn(
      String email, String password, BuildContext context) async {
    UserCredential authResult;
    try {
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthDto(authResult.user, false, null);
    } on FirebaseAuthException catch (e) {
      return AuthDto(null, true, e);
    }
  }

  Future<AuthDto> signUp(String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthDto(authResult.user, false, null);
    } on FirebaseAuthException catch (e) {
      return AuthDto(null, true, e);
    } catch (err) {
      return AuthDto(null, true, null);
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
