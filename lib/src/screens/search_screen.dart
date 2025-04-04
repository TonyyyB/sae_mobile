import 'package:flutter/material.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/restaurant_card.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';

class SearchScreen extends StatelessWidget {
  final List<String> cuisines;
  final List<String> types;
  final List<String> options;
  final String search;
  const SearchScreen(
      {super.key,
      required this.cuisines,
      required this.types,
      required this.options,
      required this.search});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>?>(
      future: DatabaseProvider.searchRestaurants(
          cuisines: cuisines,
          types: types,
          options: options,
          textSearch: search),
      builder: (context, snapshot) {
        Widget child = Text(
          "Aucun restaurant trouvé !",
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
          List<Restaurant> restaurants = snapshot.data!;
          if (restaurants.isEmpty) {
            child = Text(
              "Aucun restaurant trouvé !",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          } else {
            child = ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(restau: restaurants[index]);
              },
            );
          }
        }
        return PickMenuScaffold(
          selectedCuisines: cuisines,
          selectedOptions: options,
          selectedTypes: types,
          initialSearch: search,
          child: child,
        );
      },
    );
  }
}
