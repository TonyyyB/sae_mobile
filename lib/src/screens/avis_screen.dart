import 'package:flutter/material.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/avis_restaurant.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';

class AvisScreen extends StatelessWidget {
  final int id;
  const AvisScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant?>(
      future: DatabaseProvider.getRestaurantById(id, loadAvis: true),
      builder: (context, snapshot) {
        Widget child = Text(
          "Le restaurant d'id $id n'existe pas !",
          style: Theme.of(context).textTheme.bodyLarge,
        );
        if (snapshot.connectionState == ConnectionState.waiting) {
          child = CircularProgressIndicator();
        } else if (snapshot.hasError) {
          child = Text(
            "Une erreur s'est produite: ${snapshot.error}",
            style: Theme.of(context).textTheme.bodyLarge,
          );
        } else if (snapshot.hasData) {
          Restaurant restaurant = snapshot.data!;
          child = AvisRestaurant(restaurant: restaurant);
        }
        return PickMenuScaffold(child: child);
      },
    );
  }
}
