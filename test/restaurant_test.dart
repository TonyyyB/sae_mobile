import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/models/avis.dart';

  void main() {
    group('Restaurant Class Tests', () {
      late Restaurant restaurant;

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
      });

      test('Restaurant should be initialized correctly', () {
        expect(restaurant.osmId, 9136326362);
        expect(restaurant.longitude, 1.901334);
        expect(restaurant.latitude, 47.915769999957696);
        expect(restaurant.name, 'Freshkin');
        expect(restaurant.region, 'Centre-Val de Loire');
        expect(restaurant.departement, 'Loiret');
        expect(restaurant.commune, 'Orléans');
      });

      test('Should add cuisine correctly', () {
        restaurant.addCuisine('salad');
        expect(restaurant.cuisine, contains('salad'));
      });

      test('Should add avis correctly', () {
        Avis avis = Avis(
          id: 1,
          uuid: '1234-5678-91011',
          restaurant: restaurant,
          note: 5,
          commentaire: 'Très bon restaurant !',
        );

        restaurant.addAvis(avis);
        expect(restaurant.avis, isNotNull);
        expect(restaurant.avis!.length, 1);
        expect(restaurant.avis!.first.note, 5);
      });

      test('toString() should return formatted string', () {
        String result = restaurant.toString();
        expect(result, contains('Freshkin'));
        expect(result, contains('Centre-Val de Loire'));
      });
    });
  }

