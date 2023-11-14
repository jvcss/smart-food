import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_event.dart';
import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';
import 'package:smart_food/src/widgets/dashboard_card.dart';
import 'package:smart_food/src/widgets/dashboard_chart.dart';
import 'package:smart_food/src/widgets/dashboard_wizard.dart';
import 'package:smart_food/src/widgets/horizontal_graph.dart';
import 'package:smart_food/src/widgets/vertial_chart.dart';

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
      appBar: AppBar(
        title: Text(profile.restaurantName ?? 'Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Show the NotificationsOverlay when the icon is pressed
              showNotificationsOverlay(context);
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationSignOutEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              VerticalChartWidget(data: demoData), // Use VerticalChartWidget
              SizedBox(
                height: 20,
                child: HorizontalBarChart(
                  data: demoData,
                ),
              ),
              HorizontalBarChart(
                data: demoData,
              ),
              const SizedBox(height: 20),
              ...demoData.map(
                (data) => DashboardCardWidget(
                  title: data.title,
                  price: data.price,
                  color: data.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNotificationsOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Your content for the bottom sheet goes here
              Text('Amanhã pode ter aumento significativo de vendas'),
            ],
          ),
        );
      },
    );
  }
}
