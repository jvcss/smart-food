import 'package:flutter/material.dart';

class PersonalizedCard extends StatefulWidget {
  final String title;

  const PersonalizedCard({Key? key, required this.title}) : super(key: key);

  @override
  State<PersonalizedCard> createState() => _PersonalizedCardState();
}

Color _getColor(bool selected,
    {Color selectedColor = Colors.blue, Color unselectedColor = Colors.grey}) {
  return selected ? selectedColor : unselectedColor;
}

class _PersonalizedCardState extends State<PersonalizedCard> {
  String _selectedIntensity = '';
  bool _productSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _productSelected = !_productSelected;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: _getColor(
                      _productSelected,
                      selectedColor: Colors.white,
                      unselectedColor: Colors.white,
                    ),
                    foregroundColor: _getColor(
                      _productSelected,
                      selectedColor: ThemeData().primaryColor,
                      unselectedColor: Colors.grey,
                    ),
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Icon(Icons.circle),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IntensityButton(
                  label: 'Minímo',
                  selected: _selectedIntensity == 'Low' ? true : false,
                  onPressed: () {
                    setState(() {
                      _selectedIntensity = 'Low';
                    });
                  },
                ),
                IntensityButton(
                  label: 'Médio',
                  selected: _selectedIntensity == 'Medium' ? true : false,
                  onPressed: () {
                    setState(() {
                      _selectedIntensity = 'Medium';
                    });
                  },
                ),
                IntensityButton(
                  label: 'Máximo',
                  selected: _selectedIntensity == 'High' ? true : false,
                  onPressed: () {
                    setState(() {
                      _selectedIntensity = 'High';
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IntensityButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  const IntensityButton(
      {Key? key,
      required this.label,
      required this.selected,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getColor(
          selected,
          selectedColor: ThemeData().primaryColor,
          unselectedColor: Colors.white,
        ),
        foregroundColor: _getColor(
          selected,
          selectedColor: Colors.white,
          unselectedColor: Colors.black,
        ),
      ),
      child: Text(label),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: appTheme,
//     home: const Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               PersonalizedCard(title: 'Card Title'),
//               PersonalizedCard(title: 'Card Title 2'),
//               PersonalizedCard(title: 'Card Title 3'),
//               PersonalizedCard(title: 'Card Title 4'),
//               PersonalizedCard(title: 'Card Title 5'),
//               PersonalizedCard(title: 'Card Title 6')
//             ],
//           ),
//         ),
//       ),
//     ),
//   ));
// }
