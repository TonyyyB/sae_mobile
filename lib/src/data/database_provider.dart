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

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<void> fetchCuisines() async {
    final data = await supabase.from('style_cuisine').select();
    Restaurant.typesCuisine = {};
    for (var cuisine in data) {
      Restaurant.typesCuisine[cuisine["nom_style"]] = cuisine["style_id"];
    }
  }

  Future<String?> getCuisine(int id) async {
    final data =
        await supabase.from('style_cuisine').select().eq('style_id', id);
    return data[0]["nom_style"];
  }

  getAllRestaurants() async {
    final data = await supabase.from('restaurant').select();
    for (var res in data) {
      /*Restaurant restaurant = Restaurant(
        osmId: res['osm_id'],
        longitude: res['longitude'],
        latitude: res['latitude'],
        type: res['type_id'],
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
      );*/
    }
  }
}
