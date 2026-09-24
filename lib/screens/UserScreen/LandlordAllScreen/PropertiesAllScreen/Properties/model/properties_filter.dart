// lib/screens/UserScreen/LandlordAllScreen/Properties/model/properties_filter.dart
enum PropertiesFilter { all, occupied, vacant }

extension PropertiesFilterX on PropertiesFilter {
  String get label => switch (this) {
    PropertiesFilter.all => 'All',
    PropertiesFilter.occupied => 'Occupied',
    PropertiesFilter.vacant => 'Vacant',
  };
}