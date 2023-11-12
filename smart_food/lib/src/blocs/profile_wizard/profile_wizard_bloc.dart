import 'package:bloc/bloc.dart';

part 'profile_wizard_event.dart';
part 'profile_wizard_state.dart';

class ProfileWizardBloc extends Bloc<ProfileWizardEvent, ProfileWizardState> {
  ProfileWizardBloc() : super(ProfileWizardState.initial()) {
    on<ProfileWizardBusinessInfoSubmitted>(
      (event, emit) {
        emit(state.copyWith(
            profile: state.profile.copyWith(
                restaurantLocation: event.restaurantLocation,
                restaurantName: event.restaurantName,
                restaurantType: event.restaurantType)));
      },
    );

    on<ProfileProductSubmitted>(
      (event, emit) {
        emit(state.copyWith(
            profile: state.profile.copyWith(productList: event.productList)));
      },
    );

    on<ProfileWizardCompleted>(
      (event, emit) {
        emit(ProfileWizardCompletedState(profile: state.profile));
      },
    );
  }
}
