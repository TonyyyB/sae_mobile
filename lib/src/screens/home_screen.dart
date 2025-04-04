import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/restaurant_card.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';
import '../../models/restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(List<Restaurant>, List<double?>)>(
      future: DatabaseProvider.getTop5(),
      builder: (context, snapshot) {
        Widget child = const Center(
          child: CircularProgressIndicator(),
        );
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          List<Restaurant> restaus = snapshot.data!.$1;
          List<double?> notes = snapshot.data!.$2;
          child = ListView.builder(
            itemCount: restaus.length,
            itemBuilder: (context, index) {
              return RestaurantCard(
                restau: restaus[index],
                note: notes[index],
              );
            },
          );
        }
        return PickMenuScaffold(child: child);
      },
    );
  }
}
