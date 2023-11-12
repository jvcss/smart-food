import 'package:bloc/bloc.dart';
import 'package:smart_food/src/services/own_api_service.dart';

part 'profile_wizard_event.dart';
part 'profile_wizard_state.dart';

class ProfileWizardBloc extends Bloc<ProfileWizardEvent, ProfileWizardState> {
  final OwnAPIService backend = OwnAPIService();

  ProfileWizardBloc() : super(ProfileWizardState.initial()) {
    on<ProfileWizardBusinessInfoSubmitted>(
      (event, emit) async {
        try {
          final result = await backend.createRestaurant(
            event.restaurantName,
            event.restaurantLocation,
            event.restaurantType,
          );

          // Assuming result is the ID of the added restaurant
          final addedRestaurantId = result['id'];

          emit(
            state.copyWith(
              profile: state.profile.copyWith(
                restaurantId: addedRestaurantId,
                restaurantLocation: event.restaurantLocation,
                restaurantName: event.restaurantName,
                restaurantType: event.restaurantType,
              ),
            ),
          );
        } catch (error) {
          // Handle errors if needed
          print('Error creating restaurant: $error');
        }
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
