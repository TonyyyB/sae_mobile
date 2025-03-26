import 'package:sae_mobile/models/restaurant.dart';

class Avis {
  int id;
  String uuid;
  Restaurant restaurant;
  int note;
  String? commentaire;
  String? photo;

  Avis(
      {this.id = -1,
      required this.restaurant,
      required this.uuid,
      this.commentaire,
      required this.note,
      this.photo});

  int get getId => id;
  set setId(int value) => id = value;

  String get getUuid => uuid;
  set setUuid(String value) => uuid = value;

  Restaurant get getRestaurant => restaurant;
  set setRestaurant(Restaurant value) => restaurant = value;

  int get getNote => note;
  set setNote(int value) => note = value;

  String? get getCommentaire => commentaire;
  set setCommentaire(String? value) => commentaire = value;

  String? get getPhoto => photo;
  set setPhoto(String? value) => photo = value;

  Map<String, dynamic> insert() {
    return {
      'uuid': uuid,
      'osm_id': restaurant.osmId,
      'note': note,
      'commentaire': commentaire,
      'photo': photo
    };
  }

  @override
  String toString() {
    return 'Avis{id: $id, uuid: $uuid, restaurant: ${restaurant.name}, note: $note, commentaire: $commentaire, photo: $photo}';
  }
}
