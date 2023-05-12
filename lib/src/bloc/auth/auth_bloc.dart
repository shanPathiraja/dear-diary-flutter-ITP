
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LogInRequested>(_mapLoginToState);
    on<LogOutRequested>(_mapLogoutToState);
    on<RegisterRequested>(_mapRegisterToState);
  }

  void _mapAppStartedToState (AppStarted event, Emitter<AuthState> emit) async {
    final isSignedIn = await _authRepository.isSignedIn();
    log("isSignedIn: $isSignedIn");
    if (isSignedIn) {
      final user = await _authRepository.getUser();
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthError("Not authenticated", "Not authenticated"));
    }
  }


  void _mapLoginToState (LogInRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    log("Login requested");
    try {
      final user = await _authRepository.login(event.email, event.password);
      log("User: $user");
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (exception) {
      String title;
      String content;
      switch (exception.code) {
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
          title = 'Unknown Error';
          content = "Please try again later";
          break;
      }
      emit(AuthError(content, title));
    } catch (e) {
      log(e.toString());
      emit(AuthError(e.toString(), "Login failed"));
    }
  }

  void _mapLogoutToState (LogOutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _authRepository.logout();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString(), "Logout failed"));
    }
  }

  void _mapRegisterToState(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final userCredentials =
          await _authRepository.register(event.email, event.password);
      final user = userCredentials.user;
      emit(AuthAuthenticated(user!));
    } on FirebaseAuthException catch (exception) {
      String title;
      String content;
      switch (exception.code) {
        case "email-already-in-use":
          title = "Email already in use";
          content = "Please try another email";
          break;
        case "network-request-failed":
          title = 'network request failed';
          content = "Please check internet connection";
          break;
        case "weak-password":
          title = 'Weak Password';
          content = "Please check Password and try again";
          break;
        default:
          title = 'Unknown Error';
          content = "Please try again later";
          break;
      }
      emit(AuthError(content, title));
    } catch (e) {
      emit(AuthError(e.toString(), "Registration failed"));
    }
  }
}
