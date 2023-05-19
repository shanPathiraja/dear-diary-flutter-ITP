import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  User? user;
  bool isLoading;
  String? errorMessage;
  String? errorTitle;

  AuthState(
      {required this.user,
      required this.isLoading,
      required this.errorMessage,
      required this.errorTitle});

  static AuthState get initialState =>
      AuthState(user: null, isLoading: false, errorMessage: '', errorTitle: '');

  AuthState clone(
      {User? user,
      required bool isLoading,
      String? errorMessage,
      String? errorTitle}) {
    return AuthState(
        user: user,
        isLoading: isLoading,
        errorMessage: errorMessage,
        errorTitle: errorTitle);
  }
}
