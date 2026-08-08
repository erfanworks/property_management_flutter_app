import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocationDataModel {
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? state;
  final String? area;
  final String? postCode;
  final String? addressLine1;
  final String? addressLine2;
  final String? country;
  final String? countryCode;

  LocationDataModel({
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.area,
    this.postCode,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.countryCode,
  });

  // Convert LocationModel to JSON
  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'city': city,
    'state': state,
    'area': area,
    'postCode': postCode,
    'addressLine1': addressLine1,
    'addressLine2': addressLine2,
    'country': country,
    'countryCode': countryCode,
  };

  // Create LocationModel from JSON
  factory LocationDataModel.fromJson(Map<String, dynamic> json) => LocationDataModel(
    latitude: json['latitude'],
    longitude: json['longitude'],
    city: json['city'],
    state: json['state'],
    area: json['area'],
    postCode: json['postCode'],
    addressLine1: json['addressLine1'],
    addressLine2: json['addressLine2'],
    country: json['country'],
    countryCode: json['countryCode'],
  );

  // Save LocationModel to SharedPreferences
  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('location_model', jsonEncode(toJson()));
  }

  // Load LocationModel from SharedPreferences
  static Future<LocationDataModel?> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('location_model');
    if (jsonString != null) {
      return LocationDataModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}