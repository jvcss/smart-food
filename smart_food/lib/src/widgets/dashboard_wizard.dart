import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';
import 'package:smart_food/src/widgets/business_info_form.dart';
import 'package:smart_food/src/widgets/business_product_form.dart';
import 'package:smart_food/utils/flow_builder.dart';

extension on Profile {
  bool get isComplete =>
      restaurantName != null &&
      restaurantLocation != null &&
      restaurantType != null &&
      productList.isNotEmpty;
}

class ProfileWizardFlow extends StatelessWidget {
  const ProfileWizardFlow({required this.onComplete, super.key});

  final ValueSetter<Profile> onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileWizardBloc, ProfileWizardState>(
      listenWhen: (_, state) => state.profile.isComplete,
      listener: (context, state) => onComplete(state.profile),
      child: FlowBuilder<ProfileWizardState>(
        state: context.watch<ProfileWizardBloc>().state,
        onGeneratePages: (state, pages) {
          return [
            ProfileBusinessInfoForm.page(),
            if (state.profile.restaurantName != null &&
                state.profile.restaurantLocation != null &&
                state.profile.restaurantType != null)
              ProfileProductForm.page(),
          ];
        },
      ),
    );
  }
}
