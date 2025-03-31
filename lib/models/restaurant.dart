import 'avis.dart';

class Restaurant {
  static Map<String, int> typesCuisine = {};
  String _osmId;
  double _longitude;
  double _latitude;
  String _type;
  String _name;
  String? _operator;
  String? _brand;
  List<String>? _openingHours;
  bool? _wheelchair;
  List<String>? _cuisine;
  bool? _vegetarian;
  bool? _vegan;
  bool? _delivery;
  bool? _takeaway;
  String? _capacity;
  bool? _driveThrough;
  String? _phone;
  String? _website;
  String? _facebook;
  String _region;
  String _departement;
  String _commune;
  List<Avis>? _avis;

  Restaurant({required String osmId,required double longitude,required double latitude,required
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
      res += '$horaire\n';
    }
    return res;
  }

  String get getOsmId{
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
}
