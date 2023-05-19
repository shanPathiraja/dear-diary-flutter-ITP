
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../db/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository _authRepository;

  AuthBloc() : super(AuthState.initialState) {
    _authRepository = AuthRepository();
    on<AppStarted>(_mapAppStartedToState);
    on<LogInRequested>(_mapLoginToState);
    on<LogOutRequested>(_mapLogoutToState);
    on<RegisterRequested>(_mapRegisterToState);
  }

  void _mapAppStartedToState(AppStarted event, Emitter<AuthState> emit) async {
    final isSignedIn = await _authRepository.isSignedIn();
    emit(state.clone(isLoading: true));
    log("isSignedIn: $isSignedIn");
    if (isSignedIn) {
      final user = await _authRepository.getUser();
      emit(state.clone(user: user, isLoading: false));
    } else {
      emit(state.clone(
          user: null,
          isLoading: false,
          errorTitle: "Not authenticated",
          errorMessage: "Not authenticated"));
    }
  }


  void _mapLoginToState (LogInRequested event, Emitter<AuthState> emit) async {
    emit(state.clone(isLoading: true, errorMessage: null, errorTitle: null));
    log("Login requested");
    try {
      final user = await _authRepository.login(event.email, event.password);
      log("User: $user");
      emit(state.clone(
          user: user, isLoading: false, errorMessage: null, errorTitle: null));
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
      emit(state.clone(
          isLoading: false, errorMessage: content, errorTitle: title));
    } catch (e) {
      log(e.toString());
      emit(state.clone(
          isLoading: false,
          errorMessage: e.toString(),
          errorTitle: "Login failed"));
    }
  }

  void _mapLogoutToState (LogOutRequested event, Emitter<AuthState> emit) async {
    log("Logout requested");
    emit(state.clone(isLoading: true, errorMessage: null, errorTitle: null));
    try {
      await _authRepository.logout();
      emit(state.clone(user: null, isLoading: false));
    } catch (e) {
      emit(state.clone(
          isLoading: false,
          errorMessage: e.toString(),
          errorTitle: "Logout failed"));
    }
  }

  void _mapRegisterToState(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(state.clone(isLoading: true, errorMessage: null, errorTitle: null));
    try {
      final userCredentials =
          await _authRepository.register(event.email, event.password);
      final user = userCredentials.user;
      emit(state.clone(user: user, isLoading: false));
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
      emit(state.clone(
          isLoading: false, errorMessage: content, errorTitle: title));
    } catch (e) {
      emit(state.clone(
          isLoading: false,
          errorMessage: e.toString(),
          errorTitle: "Register failed"));
    }
  }
}
