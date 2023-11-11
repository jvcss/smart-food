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

final class ProfileWizardNameSubmitted extends ProfileWizardEvent {
  const ProfileWizardNameSubmitted(this.name);

  final String name;
}

final class ProfileWizardAgeSubmitted extends ProfileWizardEvent {
  const ProfileWizardAgeSubmitted(this.age);

  final int? age;
}

final class ProfileWizardCompleted extends ProfileWizardEvent {}
