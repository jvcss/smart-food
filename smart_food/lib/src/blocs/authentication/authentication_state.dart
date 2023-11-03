import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSignedIn extends AuthenticationState {
  final User user;

  AuthenticationSignedIn(this.user);
}

class AuthenticationSignedOut extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}
