
import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(const AuthState()) {
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
      emit(state.copyWith(status: AuthStatus.authenticated, user: user, errorMessage: null));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null, errorMessage: null));
    }
  }


  void _mapLoginToState (LogInRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, user: null, errorMessage: null));
    log("Login requested");
    try {
      final user = await _authRepository.login(event.email, event.password);
      log("User: $user");
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null, errorMessage: e.toString()));
    }
  }

  void _mapLogoutToState (LogOutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, user: null, errorMessage: null));
    try {
      await _authRepository.logout();
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null, errorMessage: e.toString()));
    }
  }

  void _mapRegisterToState(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, user: null, errorMessage: null));
    try {
      final userCredentials = await _authRepository.register(event.email, event.password);
      final user = userCredentials.user;
      emit(state.copyWith(status: AuthStatus.authenticated, user: user, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null, errorMessage: e.toString()));
    }
  }
}
