import 'avis.dart';

class Restaurant {
  String osmId;
  double longitude;
  double latitude;
  String type;
  String name;
  String? operator;
  String? brand;
  List<String>? openingHours;
  bool? wheelchair;
  List<String>? cuisine;
  bool? vegetarian;
  bool? vegan;
  bool? delivery;
  bool? takeaway;
  String? capacity;
  bool? driveThrough;
  String? phone;
  String? website;
  String? facebook;
  String region;
  String departement;
  String commune;
  List<Avis>? avis;

  Restaurant({required this.osmId,required this.longitude,required this.latitude,required
  this.type,required this.name , this.operator, this.brand, this.openingHours, this.wheelchair,
  this.cuisine, this.vegetarian, this.vegan, this.delivery, this.takeaway, this.capacity,
  this.driveThrough, this.phone, this.website, this.facebook, required this.region, required this.departement,
  required this.commune, this.avis});

  set setAvis(List<Avis> listeAvis){
    this.avis = listeAvis;
  }

  List<Avis>? get getAvis{
    return this.avis;
  }

  addAvis(Avis avis){
    this.avis ??= [];
    this.avis?.add(avis);
  }

  List<double> get getCoordinates{
    return [this.latitude, this.longitude];
  }

  double get getLatitude{
    return this.latitude;
  }

  double get getLongitude{
    return this.longitude;
  }

  List<String>? get getOpeningHours{
    return this.openingHours;
  }

  String get getOsmId{
    return this.osmId;
  }

  String get getName{
    return this.name;
  }

  String get getType{
    return this.type;
  }

  String? get getOperator{
    return this.operator;
  }

  String? get getBrand{
    return this.brand;
  }

  bool? get getWheelchair{
    return this.wheelchair;
  }

  List<String>? get getCuisine{
    return this.cuisine;
  }

  bool? get getVegetarian{
    return this.vegetarian;
  }

  bool? get getVegan{
    return this.vegan;
  }

  bool? get getDelivery{
    return this.delivery;
  }

  bool? get getTakeaway{
    return this.takeaway;
  }

  String? get getCapacity{
    return this.capacity;
  }

  bool? get getDriveThrough{
    return this.driveThrough;
  }

  String? get getphone{
    return this.phone;
  }

  String? get getWebsite{
    return this.website;
  }

  String? get getFacebook{
    return this.facebook;
  }

  String get getRegion{
    return this.region;
  }

  String get getDepartement{
    return this.departement;
  }

  String get getCommune{
    return this.commune;
  }
}
