// Define a new event for ingredient fetching
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_food/src/services/own_api_service.dart';

abstract class IngredientEvent {}

class FetchIngredientsEvent extends IngredientEvent {
  final int restaurantId;

  FetchIngredientsEvent(this.restaurantId);
}

// Define a new state for ingredient fetching
abstract class IngredientState {}

class IngredientsLoadingState extends IngredientState {}

class IngredientsLoadedState extends IngredientState {
  final List<dynamic> ingredients;

  IngredientsLoadedState(this.ingredients);
}

class IngredientsErrorState extends IngredientState {
  final String error;

  IngredientsErrorState(this.error);
}

// Define a new bloc for handling ingredient fetching
class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final OwnAPIService apiService;

  IngredientBloc(this.apiService) : super(IngredientsLoadingState()) {
    on<FetchIngredientsEvent>(
      (event, emit) async {
        emit(IngredientsLoadingState());

        try {
          final ingredients =
              await apiService.buildAISuggestIngredients(event.restaurantId);
          emit(IngredientsLoadedState(ingredients));
        } catch (e) {
          // Handle errors if needed
          emit(IngredientsErrorState(e.toString()));
          if (kDebugMode) {
            print('Error creating restaurant: $e');
          }
        }
      },
    );
  }
}
