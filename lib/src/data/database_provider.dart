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
        osmId: res['osm_id'].toString(),
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
        'uuid': supabase.auth.currentUser!.id,
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

  Future<void> ajouterFavoriRestaurant(int restaurantId) async {
    try {
      final response = await supabase.from('favoris').insert({
        'uuid': supabase.auth.currentUser?.id,
        'osm_id': restaurantId,
      });

      if (response.error != null) {
        throw Exception('Erreur lors de l\'ajout en favori : ${response.error!.message}');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  Future<void> ajouterCuisineFavorite(String nomCuisine) async {
    try {
      final data = await supabase
          .from('style_cuisine')
          .select(supabase.auth.currentUser!.id)
          .eq('nom_cuisine', nomCuisine)
          .single();

      if (data == null || data[supabase.auth.currentUser!.id] == null) {
        throw Exception('Style de cuisine non trouvé');
      }

      int idStyleCuisine = data[supabase.auth.currentUser!.id];

      final response = await supabase.from('favoris_cuisine').insert({
        'uuid': supabase.auth.currentUser?.id,
        'id_style_cuisine': idStyleCuisine,
      });

      if (response.error != null) {
        throw Exception('Erreur lors de l\'ajout de la cuisine favorite : ${response.error!.message}');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }
}
