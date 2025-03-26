import 'package:sae_mobile/models/avis.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;

  final SupabaseClient supabase = Supabase.instance.client;

  DatabaseProvider._internal();

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      final response = await supabase.auth
          .signInWithPassword(email: email, password: password);
      if (response.user != null) {
        return null;
      }
      return "Erreur inconnue lors de la connexion";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      final response =
          await supabase.auth.signUp(email: email, password: password);
      if (response.user != null) {
        return null;
      }
      return "Erreur inconnue lors de l'inscription";
    } catch (e) {
      return e.toString();
    }
  }

  bool isAuthenticated() => supabase.auth.currentSession != null;

  User? getUser() {
    return supabase.auth.currentUser;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<List<Restaurant>> getAllRestaurants() async {
    final data = await supabase.from('restaurant').select(
        "osm_id,longitude,latitude,type_restaurant(type_id, nom_type),nom_res,operator,brand,wheelchair,vegetarien,vegan,delivery,takeaway,capacity,drive_through,phone,website,facebook,region,departement,commune,possede(osm_id,style_id),style_cuisine(style_id,nom_style)");
    List<Restaurant> restaurants = [];
    for (var res in data) {
      List<String> cuisines = [];
      for (var cuisine in res['style_cuisine']) {
        cuisines.add(cuisine['nom_style']);
      }
      Restaurant restaurant = Restaurant(
        osmId: res['osm_id'],
        longitude: res['longitude'],
        latitude: res['latitude'],
        type: res['type_restaurant']['nom_type'],
        cuisine: cuisines,
        name: res['nom_res'],
        operator: res['operator'],
        brand: res['brand'],
        wheelchair: res['wheelchair'],
        vegetarian: res['vegetarien'],
        vegan: res['vegan'],
        delivery: res['delivery'],
        takeaway: res['takeaway'],
        capacity: res['capacity'],
        driveThrough: res['drive_through'],
        phone: res['phone'],
        website: res['website'],
        facebook: res['facebook'],
        region: res['region'],
        departement: res['departement'],
        commune: res['commune'],
      );
      restaurants.add(restaurant);
    }
    return restaurants;
  }

  Future<Restaurant?> getRestaurantById(int osmId) async {
    final rawData = await supabase
        .from('restaurant')
        .select(
            "osm_id,longitude,latitude,type_restaurant(type_id, nom_type),nom_res,operator,brand,wheelchair,vegetarien,vegan,delivery,takeaway,capacity,drive_through,phone,website,facebook,region,departement,commune,possede(osm_id,style_id),style_cuisine(style_id,nom_style)")
        .eq('osm_id', osmId);
    final data = rawData[0];
    List<String> cuisines = [];
    for (var cuisine in data['style_cuisine']) {
      cuisines.add(cuisine['nom_style']);
    }
    Restaurant restaurant = Restaurant(
      osmId: data['osm_id'],
      longitude: data['longitude'],
      latitude: data['latitude'],
      type: data['type_restaurant']['nom_type'],
      cuisine: cuisines,
      name: data['nom_res'],
      operator: data['operator'],
      brand: data['brand'],
      wheelchair: data['wheelchair'],
      vegetarian: data['vegetarien'],
      vegan: data['vegan'],
      delivery: data['delivery'],
      takeaway: data['takeaway'],
      capacity: data['capacity'],
      driveThrough: data['drive_through'],
      phone: data['phone'],
      website: data['website'],
      facebook: data['facebook'],
      region: data['region'],
      departement: data['departement'],
      commune: data['commune'],
    );
    return restaurant;
  }

  Future<List<Avis>> getAvisRestaurant(Restaurant restaurant) async {
    final data = await supabase
        .from('commentaire')
        .select()
        .eq('osm_id', restaurant.osmId);

    List<Avis> avisList = [];

    for (Map<String, dynamic> avisData in data) {
      Avis avis = Avis(
          id: avisData['com_id'],
          uuid: avisData['uuid'],
          restaurant: restaurant,
          note: avisData['note'],
          commentaire: avisData['commentaire'],
          photo: avisData['photo']);
      avisList.add(avis);
    }

    return avisList;
  }

  Future<int?> getCuisineId(String nomCuisine) async {
    return (await supabase
        .from('style_cuisine')
        .select('style_id')
        .eq('nom_style', nomCuisine)
        .single())['style_id'];
  }

  Future<String?> addFavoriRestaurant(int restaurantId) async {
    String? err;
    await supabase.from('favoris_restaurant').insert({
      'uuid': getUser()?.id,
      'osm_id': restaurantId,
    }).onError((error, stackTrace) {
      err = error.toString();
    });
    return err;
  }

  Future<String?> addCuisineFavorite(String nomCuisine) async {
    int? styleId = await getCuisineId(nomCuisine);
    if (styleId == null) return "Style de cuisine non trouvé !";
    String? err;
    await supabase.from('favoris_style').insert({
      'uuid': getUser()?.id,
      'style_id': styleId,
    }).onError((error, stackTrace) {
      err = error.toString();
    });
    return err;
  }
}
