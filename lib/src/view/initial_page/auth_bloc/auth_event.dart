
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;

  const RegisterRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  const LogInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogOutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}
