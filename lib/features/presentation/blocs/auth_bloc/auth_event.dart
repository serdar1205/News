part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class SignInEvent extends AuthEvent {
  final AuthParams params;

  SignInEvent(this.params);
}

final class SignUpEvent extends AuthEvent {
  final SignUpParams params;

  SignUpEvent(this.params);
}

final class SignOutEvent extends AuthEvent {}

final class GetCurrentUserEvent extends AuthEvent {}
