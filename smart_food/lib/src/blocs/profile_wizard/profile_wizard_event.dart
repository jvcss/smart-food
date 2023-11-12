part of 'profile_wizard_bloc.dart';

sealed class ProfileWizardEvent {
  const ProfileWizardEvent();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileWizardEvent && runtimeType == other.runtimeType;
  @override
  int get hashCode =>
      0; // You might want to customize this based on your class properties
}

final class ProfileWizardBusinessInfoSubmitted extends ProfileWizardEvent {
  const ProfileWizardBusinessInfoSubmitted(
      {required this.restaurantName,
      required this.restaurantLocation,
      required this.restaurantType});

  final String restaurantName;
  final String restaurantLocation;
  final String restaurantType;
}

final class ProfileProductSubmitted extends ProfileWizardEvent {
  ProfileProductSubmitted({required this.productList});

  final List<String> productList;
}

final class ProfileWizardCompleted extends ProfileWizardEvent {}
