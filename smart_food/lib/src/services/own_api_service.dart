import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_food/utils/consts.dart';

Dio myDio() {
  final options = BaseOptions(
    baseUrl: Constantes.urlApiEndpoint,
    connectTimeout: const Duration(minutes: 5),
    receiveTimeout: const Duration(minutes: 30),
  );
  return Dio(options);
}

class OwnAPIService {
  final Dio dio = myDio();

  Future<List<dynamic>> buildAISuggestIngredients(int restaurantId) async {
    try {
      final response = await dio.get('/api/restaurants/$restaurantId/');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception('Failed to load ingredients: $e');
    }
  }

  Future<List<String>> getIngredients(int restaurantId) async {
    try {
      final response = await dio.get('/api/restaurants/$restaurantId');

      if (response.statusCode == 200) {
        dynamic data = response.data['restaurant_ingredients'];
        return data;
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (error) {
      throw Exception('Failed to load restaurants: $error');
    }
  }

  Future<dynamic> createRestaurant(String restaurantName,
      String restaurantLocation, String restaurantType) async {
    try {
      final response = await dio.post(
        '/api/restaurants/',
        data: {
          'restaurant_name': restaurantName,
          'restaurant_location': restaurantLocation,
          'restaurant_type': restaurantType,
          'restaurant_ingredients': []
        },
      );

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Restaurant created successfully');
        }
        return response.data;
      } else {
        throw Exception('Failed to create restaurant');
      }
    } catch (error) {
      throw Exception('Failed to create restaurant: $error');
    }
  }
}
