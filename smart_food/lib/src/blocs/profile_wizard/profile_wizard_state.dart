part of 'profile_wizard_bloc.dart';

final class Profile {
  const Profile({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantLocation,
    required this.restaurantType,
    required this.productList,
  });

  final int? restaurantId;
  final List<String> productList;
  final String? restaurantName;
  final String? restaurantLocation;
  final String? restaurantType;

  Profile copyWith(
      {int? restaurantId,
      String? restaurantName,
      String? restaurantLocation,
      String? restaurantType,
      List<String> productList = const []}) {
    return Profile(
        restaurantId: restaurantId ?? restaurantId,
        restaurantName: restaurantName ?? restaurantName,
        restaurantLocation: restaurantLocation ?? restaurantLocation,
        restaurantType: restaurantType ?? restaurantType,
        productList: productList);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          restaurantName == other.restaurantName &&
          restaurantLocation == other.restaurantLocation &&
          restaurantType == other.restaurantType &&
          productList == other.productList &&
          restaurantId == other.restaurantId;

  @override
  int get hashCode =>
      restaurantName.hashCode ^
      restaurantLocation.hashCode ^
      restaurantType.hashCode ^
      productList.hashCode ^
      restaurantId.hashCode;
}

final class ProfileWizardState {
  ProfileWizardState({required this.profile}) : lastUpdated = DateTime.now();

  ProfileWizardState.initial()
      : this(
            profile: const Profile(
          restaurantId: null,
          restaurantName: null,
          restaurantLocation: null,
          restaurantType: null,
          productList: [],
        ));

  final Profile profile;
  final DateTime lastUpdated;

  bool get isCompleted => this is ProfileWizardCompletedState;

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

final class ProfileWizardCompletedState extends ProfileWizardState {
  ProfileWizardCompletedState({required super.profile});
}
