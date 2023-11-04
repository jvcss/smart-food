import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_event.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationSignOutEvent())
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
