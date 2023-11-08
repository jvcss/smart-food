part of 'profile_wizard_bloc.dart';

final class Profile {
  const Profile({required this.name, required this.age});

  final String? name;
  final int? age;

  Profile copyWith({String? name, int? age}) {
    return Profile(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age;

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

final class ProfileWizardState {
  ProfileWizardState({required this.profile}) : lastUpdated = DateTime.now();

  ProfileWizardState.initial()
      : this(profile: const Profile(name: null, age: null));

  final Profile profile;
  final DateTime lastUpdated;

  ProfileWizardState copyWith({Profile? profile}) {
    return ProfileWizardState(
      profile: profile ?? this.profile,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileWizardState &&
          runtimeType == other.runtimeType &&
          profile == other.profile &&
          lastUpdated == other.lastUpdated;

  @override
  int get hashCode => profile.hashCode ^ lastUpdated.hashCode;
}
