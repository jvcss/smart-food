import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_event.dart';
import 'package:smart_food/src/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
    // Dispatch the authentication event
    context
        .read<AuthenticationBloc>()
        .add(AuthenticationSignInWithGoogleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Image
          Image.asset(
            "assets/images/background.png",
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/SMART.png",
                        fit: BoxFit.contain,
                      ),
                      Image.asset(
                        "assets/images/food.png",
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                // Google Sign-In Button
                const SizedBox(height: 64),
                SignInWithGoogleButton(
                  onPressed: () => _handleSignIn(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
