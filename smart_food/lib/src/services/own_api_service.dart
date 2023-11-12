import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:smart_food/src/blocs/profile_wizard/profile_wizard_bloc.dart';

Dio myDio() {
  final options = BaseOptions(
    baseUrl: 'http://192.168.100.3:8000',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );
  return Dio(options);
}

class OwnAPIService {
  final Dio dio = myDio();

  Future<List<String>> getIngredients(String restaurantName) async {
    try {
      final response = await dio.get('/api/restaurants/13');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<String> restaurantNames =
            data.map((item) => item['name'].toString()).toList();
        return restaurantNames;
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (error) {
      throw Exception('Failed to load restaurants: $error');
    }
  }

  Future<String> createRestaurant(Profile profile) async {
    try {
      final response = await dio.post(
        '/api/restaurants/',
        data: {
          'restaurant_name': profile.restaurantName,
          'restaurant_location': profile.restaurantLocation,
          'restaurant_type': profile.restaurantType,
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
