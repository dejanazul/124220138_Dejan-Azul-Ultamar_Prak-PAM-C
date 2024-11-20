import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<List<T>> fetchListHomepage<T>(
      String menu, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse('$baseUrl/$menu'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['restaurants'] as List)
          .map((item) => fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<List<T>> fetchListImage<T>(
      String menu, String id, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse('$baseUrl/$menu/small/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['restaurants'] as List)
          .map((item) => fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<T> fetchDetail<T>(
      String menu, String id, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse('$baseUrl/$menu/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception('Failed to load $menu detail');
    }
  }
}
