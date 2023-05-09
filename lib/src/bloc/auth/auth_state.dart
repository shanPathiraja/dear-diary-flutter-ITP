

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';


enum AuthStatus{
  authenticated,
  unauthenticated,
  loading,
}

 class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;
  final Stream<User?>? userStream;

  const AuthState( {
     this.status = AuthStatus.unauthenticated,
      this.user,
      this.errorMessage,
      this.userStream,
});

  const AuthState._(this.user, {
    this.status = AuthStatus.unauthenticated,
    this.errorMessage,
    this.userStream,
  });

  const AuthState.unauthenticated() : this._(null, status: AuthStatus.unauthenticated);

  const AuthState.authenticated(User user) : this._(user, status: AuthStatus.authenticated);

  const AuthState.loading() : this._(null, status: AuthStatus.loading);

  const AuthState.error(String errorMessage) : this._(null, status: AuthStatus.unauthenticated, errorMessage: errorMessage);

  @override
  List<Object?> get props => [user, status, errorMessage, userStream];

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    errorMessage,
    userStream,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      userStream: userStream ?? this.userStream,
    );
  }

}


