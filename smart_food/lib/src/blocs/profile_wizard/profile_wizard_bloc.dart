import 'package:bloc/bloc.dart';
import 'package:smart_food/src/services/own_api_service.dart';

part 'profile_wizard_event.dart';
part 'profile_wizard_state.dart';

class ProfileWizardBloc extends Bloc<ProfileWizardEvent, ProfileWizardState> {
  final OwnAPIService backend = OwnAPIService();

  ProfileWizardBloc() : super(ProfileWizardState.initial()) {
    on<ProfileWizardBusinessInfoSubmitted>(
      (event, emit) async {
        //first we add this to the State memory
        emit(
          state.copyWith(
            profile: state.profile.copyWith(
              restaurantLocation: event.restaurantLocation,
              restaurantName: event.restaurantName,
              restaurantType: event.restaurantType,
            ),
          ),
        );
        // Then we add to to the database
        var added_restaurant = await backend.createRestaurant(state.profile);
      },
    );

    on<ProfileProductSubmitted>(
      (event, emit) {
        emit(state.copyWith(
            profile: state.profile.copyWith(productList: event.productList)));
        //todo: salvar no banco de dados via own_api_service.dart
      },
    );

    on<ProfileWizardCompleted>(
      (event, emit) {
        emit(ProfileWizardCompletedState(profile: state.profile));
      },
    );
  }
}
