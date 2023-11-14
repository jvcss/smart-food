// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/ingredients/ingredient_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intensidade de consumo')),
      body: BlocBuilder<IngredientBloc, IngredientState>(
        builder: (context, state) {
          if (state is IngredientsLoadedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IngredientList(ingredients: state.ingredients),
                  ElevatedButton(
                    onPressed: () {
                      if (state.ingredients.isNotEmpty) {
                        context.read<ProfileWizardBloc>().add(
                              ProfileProductSubmitted(
                                productList: state.ingredients,
                              ),
                            );
                        context.read<ProfileWizardBloc>().add(
                              ProfileWizardCompleted(),
                            );
                      }
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}

class IngredientList extends StatelessWidget {
  final List<dynamic> ingredients;

  const IngredientList({Key? key, required this.ingredients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert dynamic ingredients to a list of strings
    final List<String> stringIngredients =
        ingredients.map((ingredient) => ingredient.toString()).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: stringIngredients.length,
        itemBuilder: (BuildContext context, int index) {
          return PersonalizedCard(title: stringIngredients[index]);
        },
      ),
    );
  }
}
