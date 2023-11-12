import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_event.dart';
import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';
import 'package:smart_food/src/widgets/dashboard_wizard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileWizardBloc, ProfileWizardState>(
      builder: (context, state) {
        // Build UI Wizard FLow
        if (!state.isCompleted) {
          return ProfileWizardFlow(onComplete: _onWizardComplete);
        } else {
          // Wizard is completed, show the main dashboard
          return mainDashboard(context, state.profile);
        }
      },
    );
  }

  void _onWizardComplete(Profile profile) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => mainDashboard(context, profile),
      ),
    );
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
