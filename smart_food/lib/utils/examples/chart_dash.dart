import 'package:flutter/material.dart';
import 'package:smart_food/src/models/data_dashboard_model.dart';
import 'package:smart_food/src/widgets/dashboard_card.dart';
import 'package:smart_food/src/widgets/horizontal_graph.dart';
import 'package:smart_food/src/widgets/vertial_chart.dart';
import 'package:smart_food/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

final demoData = [
  DashboardData(
      title: 'Arroz Japones', price: '\$50/hour', units: 50, color: Colors.red),
  DashboardData(
      title: 'Salmão', price: '\$15/hour', units: 15, color: Colors.blue),
  DashboardData(
      title: 'Alga', price: '\$55/hour', units: 55, color: Colors.green),
  DashboardData(
      title: 'Tilapia', price: '\$60/hour', units: 60, color: Colors.orange),
  DashboardData(
      title: 'Macarrão', price: '\$65/hour', units: 65, color: Colors.purple),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
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
}
