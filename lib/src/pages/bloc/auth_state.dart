part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthloadState extends AuthState {
  final User user;

  AuthloadState(this.user);
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState(this.errorMessage);
}