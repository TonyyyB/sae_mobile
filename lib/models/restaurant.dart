import 'avis.dart';

class Restaurant {
  static Map<String, int> typesCuisine = {};
  final String _osmId;
  final double _longitude;
  final double _latitude;
  final String _type;
  final String _name;
  final String? _operator;
  final String? _brand;
  final List<String>? _openingHours;
  final bool? _wheelchair;
  final List<String>? _cuisine;
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
      {required String osmId,
      required double longitude,
      required double latitude,
      required String type,
      required String name,
      String? operator,
      String? brand,
      List<String>? openingHours,
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

  set setAvis(List<Avis> listeAvis) {
    _avis = listeAvis;
  }

  List<Avis>? get getAvis {
    return _avis;
  }

  addAvis(Avis avis) {
    _avis ??= [];
    _avis?.add(avis);
  }

  List<double> get getCoordinates {
    return [_latitude, _longitude];
  }

  double get getLatitude {
    return _latitude;
  }

  double get getLongitude {
    return _longitude;
  }

  List<String>? get getOpeningHours {
    return _openingHours;
  }

  String get getOsmId {
    return _osmId;
  }

  String get getName {
    return _name;
  }

  String get getType {
    return _type;
  }

  String? get getOperator {
    return _operator;
  }

  String? get getBrand {
    return _brand;
  }

  bool? get getWheelchair {
    return _wheelchair;
  }

  List<String>? get getCuisine {
    return _cuisine;
  }

  bool? get getVegetarian {
    return _vegetarian;
  }

  bool? get getVegan {
    return _vegan;
  }

  bool? get getDelivery {
    return _delivery;
  }

  bool? get getTakeaway {
    return _takeaway;
  }

  String? get getCapacity {
    return _capacity;
  }

  bool? get getDriveThrough {
    return _driveThrough;
  }

  String? get getphone {
    return _phone;
  }

  String? get getWebsite {
    return _website;
  }

  String? get getFacebook {
    return _facebook;
  }

  String get getRegion {
    return _region;
  }

  String get getDepartement {
    return _departement;
  }

  String get getCommune {
    return _commune;
  }
}
