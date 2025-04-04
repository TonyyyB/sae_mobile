import 'dart:io';

import 'package:sae_mobile/models/avis.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/src/widgets/filter_panel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseProvider {
  static final SupabaseClient supabase = Supabase.instance.client;

  static Future<String?> signIn(
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

  static Future<String?> signUp(
      {required String nom,
      required String prenom,
      required String email,
      required String password}) async {
    try {
      final response =
          await supabase.auth.signUp(email: email, password: password);
      if (response.user != null) {
        await supabase.from("utilisateur").insert({
          "uuid": response.user?.id,
          "nom_utilisateur": nom,
          "prenom_utilisateur": prenom
        });
        return null;
      }
      return "Erreur inconnue lors de l'inscription";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<(String, String)?> getNomPrenom(String uuid) async {
    final response =
        await supabase.from('utilisateur').select().eq('uuid', uuid).limit(1);

    if (response.isEmpty) {
      return null;
    }

    final res = response[0];

    return res['nom_utilisateur'] == null || res['prenom_utilisateur'] == null
        ? null
        : (
            res['nom_utilisateur'] as String,
            res['prenom_utilisateur'] as String
          );
  }

  static Future<(String, String)?> getSelfNomPrenom() async {
    return getNomPrenom(supabase.auth.currentUser!.id);
  }

  static bool isAuthenticated() => supabase.auth.currentSession != null;

  static User? getUser() {
    return supabase.auth.currentUser;
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Restaurant _mapToRestaurant(Map<String, dynamic> data) {
    List<String> cuisines = [];
    for (var cuisine in data['style_cuisine']) {
      cuisines.add(cuisine['nom_style']);
    }

    List<String?>? horaires;
    if (data['horaires'] != null) {
      horaires = [];
      for (var day in [
        'Lundi',
        'Mardi',
        'Mercredi',
        'Jeudi',
        'Vendredi',
        'Samedi',
        'Dimanche'
      ]) {
        horaires.add("$day: ${data['horaires'][day.toLowerCase()] ?? "Fermé"}");
      }
    }
    return Restaurant(
      osmId: data['osm_id'],
      longitude: data['longitude'],
      latitude: data['latitude'],
      openingHours: horaires,
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
  }

  static Future<List<Restaurant>> getAllRestaurants() async {
    final data = await supabase.from('restaurant').select(
        "osm_id,longitude,latitude,type_restaurant(type_id, nom_type),nom_res,operator,brand,wheelchair,vegetarien,vegan,delivery,takeaway,capacity,drive_through,phone,website,facebook,region,departement,commune,possede(osm_id,style_id),style_cuisine(style_id,nom_style), horaires(osm_id,lundi,mardi,mercredi,jeudi,vendredi,samedi,dimanche)");
    List<Restaurant> restaurants = [];
    for (var res in data) {
      restaurants.add(_mapToRestaurant(res));
    }
    return restaurants;
  }

  static Future<Restaurant?> getRestaurantById(int osmId,
      {bool loadAvis = false}) async {
    final rawData = await supabase
        .from('restaurant')
        .select(
            "osm_id,longitude,latitude,type_restaurant(type_id, nom_type),nom_res,operator,brand,wheelchair,vegetarien,vegan,delivery,takeaway,capacity,drive_through,phone,website,facebook,region,departement,commune,possede(osm_id,style_id),style_cuisine(style_id,nom_style), horaires(osm_id,lundi,mardi,mercredi,jeudi,vendredi,samedi,dimanche)")
        .eq('osm_id', osmId);
    if (rawData.isEmpty) {
      return null;
    }
    final data = rawData[0];

    final restaurant = _mapToRestaurant(data);

    if (loadAvis) {
      final List<Avis> avis = await getAvisRestaurant(restaurant);
      if (avis.isNotEmpty) {
        restaurant.avis = avis;
      }
    }
    return restaurant;
  }

  static Future<(List<Restaurant>, List<double?>)> getTop5() async {
    final data = await supabase.rpc('get_top_5');
    List<Restaurant> restaurants = [];
    List<double?> notes = [];
    for (var resData in data) {
      Restaurant? restau =
          await DatabaseProvider.getRestaurantById(resData['osm_id']);
      if (restau != null) {
        restaurants.add(restau);
        notes.add(resData['rating']);
      }
    }
    return (restaurants, notes);
  }

  static Future<List<Avis>> getAvisRestaurant(Restaurant restaurant) async {
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

// TODO la photo ne fonctionne pas
  static Future<String?> postAvisRestaurant(Avis avis, File? photo) async {
    String? err;
    await supabase
        .from('commentaire')
        .insert(avis.insert())
        .onError((error, stackTrace) {
      err = error.toString();
    });
    return err;
  }

  static Future<double?> getRestaurantNoteById(int osmId) async {
    final res = await supabase
        .rpc('get_note_restaurant', params: {'restaurant_osm_id': osmId});
    return res;
  }

  static Future<double?> getRestaurantNote(Restaurant restaurant) async {
    return getRestaurantNoteById(restaurant.osmId);
  }

  static Future<int?> getCuisineId(String nomCuisine) async {
    return (await supabase
        .from('style_cuisine')
        .select('style_id')
        .eq('nom_style', nomCuisine)
        .single())['style_id'];
  }

  static Future<String?> getTypeId(String nomStyle) async {
    return (await supabase
        .from('type_restaurant')
        .select('type_id')
        .eq('nom_type', nomStyle)
        .single())['type_id'];
  }

  static Future<String?> addFavoriRestaurant(int restaurantId) async {
    String? err;
    await supabase.from('favoris_restaurant').insert({
      'uuid': getUser()?.id,
      'osm_id': restaurantId,
    }).onError((error, stackTrace) {
      err = error.toString();
    });
    return err;
  }

  static Future<String?> addCuisineFavorite(String nomCuisine) async {
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

  static Future<String?> updateUserInfo({
    required String nom,
    required String prenom,
    String? password,
  }) async {
    final user = getUser();
    if (user == null) {
      return "Utilisateur non connecté";
    }

    String? err;

    await supabase
        .from("utilisateur")
        .update({
          "nom_utilisateur": nom,
          "prenom_utilisateur": prenom,
        })
        .eq("uuid", user.id)
        .onError((error, stackTrace) {
          err = error.toString();
        });

    if (err != null) {
      return err;
    }

    if (password != null && password.isNotEmpty) {
      try {
        await supabase.auth.updateUser(
          UserAttributes(password: password),
        );
      } catch (e) {
        return e.toString();
      }
    }

    return null;
  }
  // À ajouter à la classe DatabaseProvider

  static Future<List<Restaurant>> getFavoriteRestaurants() async {
    final user = getUser();
    if (user == null) {
      return [];
    }

    // Récupérer les IDs des restaurants favoris de l'utilisateur
    final favorisData = await supabase
        .from('favoris_restaurant')
        .select('osm_id')
        .eq('uuid', user.id);

    if (favorisData.isEmpty) {
      return [];
    }

    // Extraire les IDs des restaurants
    List<int> restaurantIds =
        favorisData.map<int>((item) => item['osm_id'] as int).toList();

    // Récupérer les détails de chaque restaurant favori
    List<Restaurant> favoriteRestaurants = [];
    for (int id in restaurantIds) {
      Restaurant? restaurant = await getRestaurantById(id, loadAvis: false);
      if (restaurant != null) {
        favoriteRestaurants.add(restaurant);
      }
    }

    return favoriteRestaurants;
  }

  static Future<bool> isRestaurantFavorite(int restaurantId) async {
    final user = getUser();
    if (user == null) {
      return false;
    }

    final data = await supabase
        .from('favoris_restaurant')
        .select()
        .eq('uuid', getUser()!.id)
        .eq('osm_id', restaurantId);

    return data.isNotEmpty;
  }

  static Future<Map<int, String>> getAllCuisines() async {
    final response =
        await supabase.from('style_cuisine').select('style_id, nom_style');
    Map<int, String> res = {};
    for (Map<String, dynamic> data in response) {
      res[data['style_id']] = data['nom_style'];
    }
    return res;
  }

  static Future<Map<int, String>> getAllTypes() async {
    final response =
        await supabase.from('type_restaurant').select('type_id, nom_type');
    Map<int, String> res = {};
    for (Map<String, dynamic> data in response) {
      res[data['type_id']] = data['nom_type'];
    }
    return res;
  }

  static Future<List<Restaurant>> searchRestaurants({
    required List<String> cuisines,
    required List<String> types,
    required List<String> options,
    String? textSearch,
  }) async {
    var query = supabase.from('restaurant').select(
        "osm_id,longitude,latitude,type_restaurant(type_id, nom_type),nom_res,operator,brand,wheelchair,vegetarien,vegan,delivery,takeaway,capacity,drive_through,phone,website,facebook,region,departement,commune,possede(osm_id,style_id),style_cuisine(style_id,nom_style), horaires(osm_id,lundi,mardi,mercredi,jeudi,vendredi,samedi,dimanche)");

    final List<Map<String, dynamic>> result = await query;
    List<Restaurant> restaurants = [];

    for (var resData in result) {
      if (resData['type_restaurant'] == null) {
        continue;
      }

      if (types.isNotEmpty) {
        String? resType = resData['type_restaurant']['nom_type'];
        if (resType == null || !types.contains(resType)) {
          continue;
        }
      }

      if (textSearch != null && textSearch.isNotEmpty) {
        String? restaurantName = resData['nom_res']?.toString().toLowerCase();
        if (restaurantName == null ||
            !restaurantName.contains(textSearch.toLowerCase())) {
          continue;
        }
      }

      Restaurant restaurant = _mapToRestaurant(resData);

      bool hasCuisine = cuisines.isEmpty;
      if (!hasCuisine && restaurant.cuisine != null) {
        for (String cuisine in restaurant.cuisine!) {
          if (cuisines.contains(cuisine)) {
            hasCuisine = true;
            break;
          }
        }
      }

      bool hasOptions = true;
      for (String optionLabel in options) {
        String? optionBdName = FilterPanel.OPTIONS[optionLabel];
        if (optionBdName == null) continue;

        switch (optionBdName) {
          case 'vegetarien':
            if (restaurant.vegetarian != true) hasOptions = false;
            break;
          case 'vegan':
            if (restaurant.vegan != true) hasOptions = false;
            break;
          case 'delivery':
            if (restaurant.delivery != true) hasOptions = false;
            break;
          case 'takeaway':
            if (restaurant.takeaway != true) hasOptions = false;
            break;
          case 'drive_through':
            if (restaurant.driveThrough != true) hasOptions = false;
            break;
          case 'wheelchair':
            if (restaurant.wheelchair != 'yes') hasOptions = false;
            break;
        }

        if (!hasOptions) break;
      }

      if (hasCuisine && hasOptions) {
        restaurants.add(restaurant);
      }
    }

    return restaurants;
  }

  static Future<bool> isRestaurantFavori(int restaurantId) async {
    final data = await supabase
        .from('favoris_restaurant')
        .select()
        .eq('uuid', getUser()!.id)
        .eq('osm_id', restaurantId);

    return data.isNotEmpty;
  }

  static Future<List<Restaurant>> getFavorisRestaurants() async {
    final data = await supabase
        .from('favoris_restaurant')
        .select('osm_id')
        .eq('uuid', getUser()!.id);

    List<Restaurant> favoris = [];
    for (var item in data) {
      Restaurant? restaurant = await getRestaurantById(item['osm_id']);
      if (restaurant != null) {
        favoris.add(restaurant);
      }
    }

    return favoris;
  }

  static Future<String?> removeFavoriRestaurant(int restaurantId) async {
    final user = getUser();
    if (user == null) {
      return "Utilisateur non connecté";
    }

    String? err;
    await supabase
        .from('favoris_restaurant')
        .delete()
        .eq('uuid', getUser()!.id)
        .eq('osm_id', restaurantId)
        .onError((error, stackTrace) {
      err = error.toString();
    });
    return err;
  }

  static Future<(bool, String?)> toggleFavoriRestaurant(
      int restaurantId) async {
    bool isFavori = await isRestaurantFavori(restaurantId);
    String? err;

    if (isFavori) {
      err = await removeFavoriRestaurant(restaurantId);
      return (err.toString().isNotEmpty, err);
    } else {
      err = await addFavoriRestaurant(restaurantId);
      return (err.toString().isNotEmpty, err);
    }
  }

  static Future<String?> removeCuisineFavorite(String nomCuisine) async {
    int? styleId = await getCuisineId(nomCuisine);
    if (styleId == null) return "Style de cuisine non trouvé !";

    String? err;
    await supabase
        .from('favoris_style')
        .delete()
        .eq('uuid', getUser()!.id)
        .eq('style_id', styleId)
        .onError((error, stackTrace) {
      err = error.toString();
    });

    return err;
  }

  static Future<bool> isCuisineFavorite(String nomCuisine) async {
    int? styleId = await getCuisineId(nomCuisine);
    if (styleId == null) return false;

    final data = await supabase
        .from('favoris_style')
        .select()
        .eq('uuid', getUser()!.id)
        .eq('style_id', styleId);

    return data.isNotEmpty;
  }

  static Future<List<String>> getFavorisCuisines() async {
    final data = await supabase
        .from('favoris_style')
        .select('style_id')
        .eq('uuid', getUser()!.id);

    List<String> favoris = [];
    for (var item in data) {
      final styleData = await supabase
          .from('style_cuisine')
          .select('nom_style')
          .eq('style_id', item['style_id'])
          .single();

      favoris.add(styleData['nom_style']);
    }

    return favoris;
  }

  static Future<(bool, String?)> toggleFavoriCuisine(String nomCuisine) async {
    bool isFavori = await isCuisineFavorite(nomCuisine);
    String? err;

    if (isFavori) {
      err = await removeCuisineFavorite(nomCuisine);
      return (err.toString().isNotEmpty, err);
    } else {
      err = await addCuisineFavorite(nomCuisine);
      return (err.toString().isNotEmpty, err);
    }
  }
}
