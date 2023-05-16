part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String errorTitle;
  final String errorMessage;

  const AuthError(this.errorTitle, this.errorMessage);
}
