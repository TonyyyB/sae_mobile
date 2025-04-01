import 'package:sae_mobile/models/restaurant.dart';

class Avis {
  int _id;
  String _uuid;
  Restaurant _restaurant;
  int _note;
  String? _commentaire;
  String? _photo;

  Avis(
      {int id = -1,
      required Restaurant restaurant,
      required String uuid,
      String? commentaire,
      required int note,
      String? photo})
      : _commentaire = commentaire,
        _photo = photo,
        _note = note,
        _restaurant = restaurant,
        _uuid = uuid,
        _id = id;

  int get id => _id;
  set id(int value) => _id = value;

  String get uuid => _uuid;
  set uuid(String value) => _uuid = value;

  Restaurant get restaurant => _restaurant;
  set restaurant(Restaurant value) => _restaurant = value;

  int get note => _note;
  set note(int value) => _note = value;

  String? get commentaire => _commentaire;
  set commentaire(String? value) => _commentaire = value;

  String? get photo => _photo;
  set photo(String? value) => _photo = value;

  Map<String, dynamic> insert() {
    return {
      'uuid': _uuid,
      'osm_id': _restaurant.getOsmId,
      'note': _note,
      'commentaire': _commentaire,
      'photo': _photo
    };
  }

  @override
  String toString() {
    return 'Avis{id: $_id, uuid: $_uuid, restaurant: ${_restaurant.getName}, note: $_note, commentaire: $_commentaire, photo: $_photo}';
  }
}
