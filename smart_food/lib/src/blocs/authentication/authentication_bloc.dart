import 'package:flutter_bloc/flutter_bloc.dart';
// Service
import 'package:smart_food/src/services/google_sign_in_service.dart';
// Events
import 'package:smart_food/src/blocs/authentication/authentication_event.dart';
// States
import 'package:smart_food/src/blocs/authentication/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final GoogleSignInService googleSignInService = GoogleSignInService();

    on<AuthenticationSignInWithGoogleEvent>((event, emit) async {
      final user = await googleSignInService.signInWithGoogle();
      try {
        if (user != null) {
          emit(AuthenticationSignedIn(user));
        } else {
          emit(AuthenticationError('Google Sign-In failed.'));
        }
      } catch (e) {
        emit(AuthenticationError('An error occurred: $e'));
      }
    });

    on<AuthenticationSignOutEvent>((event, emit) async {
      if (state is AuthenticationSignedIn) {
        try {
          await googleSignInService.signOutFromGoogle();
          emit(AuthenticationSignedOut());
        } catch (e) {
          emit(AuthenticationError('An error occurred during sign-out: $e'));
        }
      } else {
        // User is not signed in
        emit(AuthenticationError('User is not signed in'));
      }
    });

    on<AuthenticationCheckStatusEvent>((event, emit) async {
      emit(AuthenticationCheckingStatus());

      if (googleSignInService.getFirebaseUser() != null) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
  }
}
