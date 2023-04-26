import 'package:firebase_auth/firebase_auth.dart';

class AuthDto{
  final User? user;
  final bool isError;
  final FirebaseAuthException? error;


  AuthDto(this.user, this.isError, this.error);
}