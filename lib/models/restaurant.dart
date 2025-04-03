import 'avis.dart';

class Restaurant {
  final int _osmId;
  final double _longitude;
  final double _latitude;
  final String _type;
  final String _name;
  final String? _operator;
  final String? _brand;
  final List<String>? _openingHours;
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

  Restaurant({required int osmId,required double longitude,required double latitude,required
  String type,required String name , String? operator, String? brand, List<String>? openingHours, bool? wheelchair,
  List<String>? cuisine, bool? vegetarian, bool? vegan, bool? delivery, bool? takeaway, String? capacity,
  bool? driveThrough, String? phone, String? website, String? facebook, required String region, required String departement,
  required String commune, List<Avis>? avis}) : _avis = avis, _commune = commune, _departement = departement, _region = region, _facebook = facebook, _website = website, _phone = phone, _driveThrough = driveThrough, _capacity = capacity, _takeaway = takeaway, _delivery = delivery, _vegan = vegan, _vegetarian = vegetarian, _cuisine = cuisine, _wheelchair = wheelchair, _openingHours = openingHours, _brand = brand, _operator = operator, _name = name, _type = type, _latitude = latitude, _longitude = longitude, _osmId = osmId;

  set setAvis(List<Avis> listeAvis){
    this._avis = listeAvis;
  }

  List<Avis>? get getAvis{
    return this._avis;
  }

  addAvis(Avis avis){
    this._avis ??= [];
    this._avis?.add(avis);
  }

  List<double> get getCoordinates{
    return [this._latitude, this._longitude];
  }

  double get getLatitude{
    return this._latitude;
  }

  double get getLongitude{
    return this._longitude;
  }

  List<String>? get getOpeningHours{
    return this._openingHours;
  }

  String get parseOpeningHours{
    var res = "";
    for (var horaire in _openingHours!){
      res += '      $horaire\n';
    }
    return res;
  }

  int get getOsmId{
    return this._osmId;
  }

  String get getName{
    return this._name;
  }

  String get getType{
    return this._type;
  }

  String? get getOperator{
    return this._operator;
  }

  String? get getBrand{
    return this._brand;
  }

  bool? get getWheelchair{
    return this._wheelchair;
  }

  List<String>? get getCuisine{
    return this._cuisine;
  }

  bool? get getVegetarian{
    return this._vegetarian;
  }

  bool? get getVegan{
    return this._vegan;
  }

  bool? get getDelivery{
    return this._delivery;
  }

  bool? get getTakeaway{
    return this._takeaway;
  }

  String? get getCapacity{
    return this._capacity;
  }

  bool? get getDriveThrough{
    return this._driveThrough;
  }

  String? get getphone{
    return this._phone;
  }

  String? get getWebsite{
    return this._website;
  }

  String? get getFacebook{
    return this._facebook;
  }

  String get getRegion{
    return this._region;
  }

  String get getDepartement{
    return this._departement;
  }

  String get getCommune{
    return this._commune;

  }

  double get getGlobalRate{
    var res = 0.0;
    var diviser = 0;
    if (_avis == null){return 0.0;}
    for (var avis in _avis!){
      res += avis.note;
      diviser += 1;
    }
    return res/diviser;
  }

  String? get parseCuisine{
    if (_cuisine == null){return null;}
    var res = "";
    for (var cook in _cuisine!){
      res += '$cook, ';
    }
    return res;
  }
}
