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
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final userCredentials = await _authRepository.register(email, password);
      if (userCredentials.user == null) {
        emit(const AuthError("User is null"));
        return;
      } else {
        emit(Authenticated(userCredentials.user!));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
