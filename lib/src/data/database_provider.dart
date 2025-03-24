import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

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

  Future<List<Avis>> getAvisRestaurant(int id) async {
    final data = await supabase
        .from('commentaire')
        .select()
        .eq('osm_id', id);

    List<Avis> avisList = [];

    for (var res in data) {
      String? photoUrl;

      if (res['photo'] != null && res['photo'] != '') {

        photoUrl = supabase.storage
            .from('photos')
            .getPublicUrl(res['photo']);
      }

      Avis avis = Avis(
        utilisateur: res['uuid'],
        commentaire: res['commentaire'],
        note: res['note'],
        image: photoUrl,
      );

      avisList.add(avis);
    }

    return avisList;
  }




  Future<void> ajouterAvisRestaurant(int id, Avis avis, Uint8List? imageBytes, String? imageName) async {
    try {
      String? imagePath;


      if (imageBytes != null && imageName != null) {
        final storageResponse = await supabase.storage
            .from('nom_de_ton_bucket') // Remplace par ton bucket
            .upload('avis/$imageName', imageBytes);

        if (storageResponse.isEmpty) {
          throw Exception('Échec de l\'upload de l\'image');
        }


        imagePath = 'avis/$imageName';
      }


      final response = await supabase.from('commentaire').insert({
        'osm_id': id,
        'uuid': avis.utilisateur,
        'commentaire': avis.commentaire,
        'note': avis.note,
        'photo': imagePath,
      });

      if (response.error != null) {
        throw Exception('Erreur lors de l\'ajout de l\'avis : ${response.error!.message}');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }


}
