abstract class AuthenticationEvent {}

class AuthenticationSignInWithGoogleEvent extends AuthenticationEvent {}

class AuthenticationSignOutEvent extends AuthenticationEvent {}

class AuthenticationCheckStatusEvent extends AuthenticationEvent {}
