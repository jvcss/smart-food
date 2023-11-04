import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign-In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationSignInWithGoogleEvent());
              },
              child: const Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
