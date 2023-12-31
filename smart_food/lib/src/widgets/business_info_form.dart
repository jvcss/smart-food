import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/ingredients/ingredient_bloc.dart';
import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';

class ProfileBusinessInfoForm extends StatefulWidget {
  const ProfileBusinessInfoForm({super.key});

  static Page<void> page() {
    return const MaterialPage<void>(child: ProfileBusinessInfoForm());
  }

  @override
  State<ProfileBusinessInfoForm> createState() =>
      ProfileBusinessInfoFormState();
}

class ProfileBusinessInfoFormState extends State<ProfileBusinessInfoForm> {
  var _restaurantName = '';
  var _restaurantLocation = '';
  var _restaurantType = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileWizardBloc, ProfileWizardState>(
      listener: (context, state) {
        if (state.profile.restaurantId! > 0) {
          // The business info is successfully submitted,
          // now you can get the restaurantId
          final restaurantId = state.profile.restaurantId;

          // Dispatch FetchIngredientsEvent with the obtained restaurantId
          context.read<IngredientBloc>().add(
                FetchIngredientsEvent(
                  restaurantId!,
                ),
              );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sobre seu negócio'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => _restaurantName = value),
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'PitDog Bom',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) =>
                      setState(() => _restaurantLocation = value),
                  decoration: const InputDecoration(
                    labelText: 'Localizacao',
                    hintText: 'Rua Asa 9',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => setState(() => _restaurantType = value),
                  decoration: const InputDecoration(
                    labelText: 'Tipo de restaurante',
                    hintText: 'Sanduicheria',
                  ),
                ),
                ElevatedButton(
                  onPressed: _restaurantName.isNotEmpty &&
                          _restaurantLocation.isNotEmpty &&
                          _restaurantType.isNotEmpty
                      ? () {
                          context.read<ProfileWizardBloc>().add(
                                ProfileWizardBusinessInfoSubmitted(
                                  restaurantId: 0,
                                  restaurantName: _restaurantName,
                                  restaurantLocation: _restaurantLocation,
                                  restaurantType: _restaurantType,
                                ),
                              );
                        }
                      : null,
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
