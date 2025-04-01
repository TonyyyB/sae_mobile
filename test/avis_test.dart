import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/models/avis.dart';

void main() {
  group('Avis Class Tests', () {
    late Restaurant restaurant;
    late Avis avis;

    setUp(() {
      restaurant = Restaurant(
        osmId: 9136326362,
        longitude: 1.901334,
        latitude: 47.915769999957696,
        type: 'restaurant',
        name: 'Freshkin',
        region: 'Centre-Val de Loire',
        departement: 'Loiret',
        commune: 'Orléans',
      );

      avis = Avis(
        id: 1,
        uuid: '1234-5678-91011',
        restaurant: restaurant,
        note: 5,
        commentaire: 'Superbe expérience !',
        photo: 'photo_url.jpg',
      );
    });

    test('Avis should be initialized correctly', () {
      expect(avis.id, 1);
      expect(avis.uuid, '1234-5678-91011');
      expect(avis.restaurant.name, 'Freshkin');
      expect(avis.note, 5);
      expect(avis.commentaire, 'Superbe expérience !');
      expect(avis.photo, 'photo_url.jpg');
    });

    test('Avis toString() should return formatted string', () {
      String result = avis.toString();
      expect(result, contains('1234-5678-91011'));
      expect(result, contains('Freshkin'));
      expect(result, contains('Superbe expérience !'));
    });

    test('Avis insert() should return a valid map', () {
      Map<String, dynamic> data = avis.insert();
      expect(data['uuid'], '1234-5678-91011');
      expect(data['osm_id'], 9136326362);
      expect(data['note'], 5);
      expect(data['commentaire'], 'Superbe expérience !');
      expect(data['photo'], 'photo_url.jpg');
    });
  });
}
