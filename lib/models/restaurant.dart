import 'avis.dart';

class Restaurant {
  final int _osmId;
  final double _longitude;
  final double _latitude;
  final String _type;
  final String _name;
  final String? _operator;
  final String? _brand;
  final List<String?>? _openingHours;
  final bool? _wheelchair;
  List<String>? _cuisine;
  final bool? _vegetarian;
  final bool? _vegan;
  final bool? _delivery;
  final bool? _takeaway;
  final String? _capacity;
  final bool? _driveThrough;
  final String? _phone;
  final String? _website;
  final String? _facebook;
  final String _region;
  final String _departement;
  final String _commune;
  List<Avis>? _avis;

  Restaurant(
      {required int osmId,
      required double longitude,
      required double latitude,
      required String type,
      required String name,
      String? operator,
      String? brand,
      List<String?>? openingHours,
      bool? wheelchair,
      List<String>? cuisine,
      bool? vegetarian,
      bool? vegan,
      bool? delivery,
      bool? takeaway,
      String? capacity,
      bool? driveThrough,
      String? phone,
      String? website,
      String? facebook,
      required String region,
      required String departement,
      required String commune,
      List<Avis>? avis})
      : _avis = avis,
        _commune = commune,
        _departement = departement,
        _region = region,
        _facebook = facebook,
        _website = website,
        _phone = phone,
        _driveThrough = driveThrough,
        _capacity = capacity,
        _takeaway = takeaway,
        _delivery = delivery,
        _vegan = vegan,
        _vegetarian = vegetarian,
        _cuisine = cuisine,
        _wheelchair = wheelchair,
        _openingHours = openingHours,
        _brand = brand,
        _operator = operator,
        _name = name,
        _type = type,
        _latitude = latitude,
        _longitude = longitude,
        _osmId = osmId;

  int get osmId => _osmId;
  double get longitude => _longitude;
  double get latitude => _latitude;
  String get type => _type;
  String get name => _name;
  String? get operator => _operator;
  String? get brand => _brand;
  List<String?>? get openingHours => _openingHours;
  bool? get wheelchair => _wheelchair;
  List<String>? get cuisine => _cuisine;
  bool? get vegetarian => _vegetarian;
  bool? get vegan => _vegan;
  bool? get delivery => _delivery;
  bool? get takeaway => _takeaway;
  String? get capacity => _capacity;
  bool? get driveThrough => _driveThrough;
  String? get phone => _phone;
  String? get website => _website;
  String? get facebook => _facebook;
  String get region => _region;
  String get departement => _departement;
  String get commune => _commune;
  List<Avis>? get avis => _avis;

  set cuisine(List<String>? value) => _cuisine = value;
  set avis(List<Avis>? value) => _avis = value;

  void addAvis(Avis avis) {
    _avis ??= [];
    _avis!.add(avis);
  }


  @override
  String toString() {
    return 'Restaurant{name: $_name, type: $_type, region: $_region, departement: $_departement, commune: $_commune, cuisine: $_cuisine, vegetarian: $_vegetarian, vegan: $_vegan, delivery: $_delivery, takeaway: $_takeaway, phone: $_phone, website: $_website, openingHours: $openingHours}';
  }

  double get getGlobalRate {
    var res = 0.0;
    var diviser = 0;
    if (_avis == null) {
      return 0.0;
    }
    for (var avis in _avis!) {
      res += avis.note;
      diviser += 1;
    }
    return res / diviser;
  }

  String? get parseCuisine {
    if (_cuisine == null) {
      return null;
    }
    var res = "";
    for (var cook in _cuisine!) {
      res += '$cook, ';
    }
    return res;
  }
}
