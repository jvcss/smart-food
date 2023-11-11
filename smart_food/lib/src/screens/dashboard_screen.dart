import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/main_dev.dart';
import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_event.dart';
import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileWizardBloc, ProfileWizardState>(
      listener: (context, state) {
        if (state.isCompleted) {
          // Wizard is completed, navigate or perform other actions
          final profile = state.profile;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => mainDashboard(context, profile)),
          );
        }
      },
      builder: (context, state) {
        // Build UI based on the current state
        if (!state.isCompleted) {
          return ProfileWizardFlow(onComplete: _onWizardComplete);
        } else {
          // Wizard is completed, show the main dashboard
          return const SizedBox
              .shrink(); // Return an empty widget as we'll navigate to mainDashboard
        }
      },
    );
  }

  void _onWizardComplete(Profile profile) {
    (profile) => Navigator.of(context).pop(profile);
    // Handle the completion of the wizard, if needed
    // You can perform actions or update the UI based on the completed profile
    // For example, you can dispatch an event to update the user's profile in your system.
  }

  Scaffold mainDashboard(BuildContext context, Profile profile) {
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
