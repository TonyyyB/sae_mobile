import 'package:flutter/material.dart';
import 'package:sae_mobile/src/widgets/restaurant_card.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PickMenuScaffold(
      child: RestaurantCard(),
    );
  }
}