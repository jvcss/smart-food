import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}

final demoData = [];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chartData = [
      Data(units: 15, color: Colors.red),
      Data(units: 20, color: Colors.blue),
      Data(units: 12, color: Colors.green),
      Data(units: 10, color: Colors.orange),
      Data(units: 50, color: Colors.purple),
    ];

    final cardData = [
      CardData(
        title: 'JavaScript',
        price: '\$50/hour',
        color: Colors.red,
      ),
      CardData(
        title: 'Python',
        price: '\$45/hour',
        color: Colors.blue,
      ),
      CardData(
        title: 'Docker',
        price: '\$55/hour',
        color: Colors.green,
      ),
      CardData(
        title: 'C#',
        price: '\$60/hour',
        color: Colors.orange,
      ),
      CardData(
        title: 'Flutter',
        price: '\$65/hour',
        color: Colors.purple,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 20,
                  child: HorizontalBarChart(
                    data: chartData,
                  ),
                ),
                HorizontalBarChart(
                  data: chartData,
                ),
                //HorizontalBarChart(data: barChartData),
                const SizedBox(height: 20),
                ...cardData.map(
                  (card) => MyCardWidget(
                    title: card.title,
                    price: card.price,
                    color: card.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// HORIZONTAL BAR RELATED
class HorizontalBarChart extends StatelessWidget {
  final List<Data> data;
  final double gap;

  const HorizontalBarChart({
    Key? key,
    required this.data,
    this.gap = .02,
  }) : super(key: key);

  List<double> get processedStops {
    double totalGapsWith = gap * (data.length - 1);
    double totalData = data.fold(0, (a, b) => a + b.units);
    return data.fold(<double>[0.0], (List<double> l, d) {
      l.add(l.last + d.units * (1 - totalGapsWith) / totalData);
      l.add(l.last);
      l.add(l.last + gap);
      l.add(l.last);
      return l;
    })
      ..removeLast()
      ..removeLast()
      ..removeLast();
  }

  List<Color> get processedColors {
    return data.fold(
        <Color>[],
        (List<Color> l, d) => [
              ...l,
              d.color,
              d.color,
              Colors.transparent,
              Colors.transparent,
            ])
      ..removeLast()
      ..removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(500),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: processedStops,
          colors: processedColors,
        ),
      ),
    );
  }
}

class Data {
  final double units;
  final Color color;

  Data({required this.units, required this.color});
}

//CARD RELATED

class MyCardWidget extends StatelessWidget {
  final String title;
  final String price;
  final Color color;

  const MyCardWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              price,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class CardData {
  final String title;
  final String price;
  final Color color;

  CardData({
    required this.title,
    required this.price,
    required this.color,
  });
}
