import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  StreamSubscription? _authSubscription;

  AuthCubit() : super(const AuthInitial());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  void _authStateChanged(String? uid) {
    if (uid != null) {
      _authRepository.getUser().then((user) {
        emit(Authenticated(user));
      });
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> signOut() async {
    await _authRepository.logout();
    emit(const Unauthenticated());
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.login(email, password);
      emit(Authenticated(user));
    } on FirebaseAuthException catch (exception) {
      String title;
      String message;
      switch (exception.code) {
        case "user-not-found":
          title = "User Not found";
          message = "Please check your email";
          break;
        case "network-request-failed":
          title = 'network request failed';
          message = "Please check internet connection";
          break;
        case "wrong-password":
          title = 'Invalid Password';
          message = "Please check Password and try again";
          break;
        default:
          title = 'Unknown Error';
          message = "Please try again later";
          break;
      }
      emit(AuthError(title, message));
    } catch (e) {
      emit(AuthError("Unknown Error", e.toString()));
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final userCredentials = await _authRepository.register(email, password);
      if (userCredentials.user == null) {
        emit(const AuthError("Unknown Error", "Please try again later"));
        return;
      } else {
        emit(Authenticated(userCredentials.user!));
      }
    } on FirebaseAuthException catch (exception) {
      String title;
      String message;
      switch (exception.code) {
        case "email-already-in-use":
          title = "Email Already in use";
          message = "Please try another email";
          break;
        case "network-request-failed":
          title = 'network request failed';
          message = "Please check internet connection";
          break;
        default:
          title = 'Unknown Error';
          message = "Please try again later";
          break;
      }
      emit(AuthError(title, message));
    } catch (e) {
      emit(AuthError("Unknown Error", e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
