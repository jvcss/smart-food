import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_state.dart';
import 'package:smart_food/src/blocs/ingredients/ingredient_bloc.dart';
import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';

import 'package:smart_food/src/screens/dashboard_screen.dart';
import 'package:smart_food/src/screens/login_screen.dart';
import 'package:smart_food/src/services/own_api_service.dart';
import 'package:smart_food/utils/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  OwnAPIService apiService = OwnAPIService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (_) => ProfileWizardBloc(),
        ),
        BlocProvider(
          create: (_) => IngredientBloc(apiService),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Food',
        theme: appTheme,
        home: const AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSignedIn) {
          return const DashboardScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
