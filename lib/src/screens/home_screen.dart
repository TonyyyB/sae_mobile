import 'package:flutter/material.dart';
import 'package:sae_mobile/src/widgets/restaurant_card.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';
import '../../models/restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var restau = new Restaurant(
        osmId: 1,
        longitude: 1.9052942,
        latitude: 47.90114979996115,
        type: "fast_food",
        name: "Cha+",
        openingHours: [
          "Mo: 8h-18h30",
          "Tu: 8h-18h30",
          "We: 8h-18h30",
          "Th: 8h-18h30",
          "Fr: 8h-18h30",
          "Sa: 8h-18h30",
          "Su: 8h-18h30"
        ],
        region: "Centre-Val de Loire",
        departement: "Loiret",
        commune: "Orléans");
    return PickMenuScaffold(
      child: SingleChildScrollView(
          child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return RestaurantCard(restau: restau);
              })),
    );
  }
}
