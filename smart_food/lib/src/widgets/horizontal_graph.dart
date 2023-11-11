import 'package:flutter/material.dart';
import 'package:smart_food/src/models/data_dashboard_model.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<DashboardData> data;
  final double gap;

  const HorizontalBarChart({
    Key? key,
    required this.data,
    this.gap = .002,
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
