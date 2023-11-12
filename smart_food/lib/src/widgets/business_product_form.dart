import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';
import 'package:smart_food/src/widgets/product_select_card.dart';

class ProfileProductForm extends StatefulWidget {
  const ProfileProductForm({super.key});

  static Page<void> page() {
    return const MaterialPage<void>(child: ProfileProductForm());
  }

  @override
  State<ProfileProductForm> createState() => ProfileProductFormState();
}

class ProfileProductFormState extends State<ProfileProductForm> {
  List<String> _productsAndIntesity = ['item um', 'item 2'];

  @override
  Widget build(BuildContext context) {
    // Receive the list from backend based on the type of restaurant
    // provided in the step event: ProfileWizardBusinessInfoSubmitted
    return Scaffold(
      appBar: AppBar(title: const Text('Intensidade de consumo')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              PersonalizedCard(title: 'Card Title'),
              PersonalizedCard(title: 'Card Title 2'),
              PersonalizedCard(title: 'Card Title 3'),
              PersonalizedCard(title: 'Card Title 4'),
              PersonalizedCard(title: 'Card Title 5'),
              PersonalizedCard(title: 'Card Title 6'),
              ElevatedButton(
                onPressed: () {
                  if (_productsAndIntesity.isNotEmpty) {
                    context.read<ProfileWizardBloc>().add(
                          ProfileProductSubmitted(
                              productList: _productsAndIntesity),
                        );
                    context
                        .read<ProfileWizardBloc>()
                        .add(ProfileWizardCompleted());
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
