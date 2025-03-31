import 'package:flutter/material.dart';
import 'package:sae_mobile/src/widgets/restaurant_card.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PickMenuScaffold(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Bienvenue, User !",
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Restaurants à la une:",
                style: Theme.of(context).textTheme.titleMedium),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return RestaurantCard();
                  })),
        ],
      ),
    );
  }
}
