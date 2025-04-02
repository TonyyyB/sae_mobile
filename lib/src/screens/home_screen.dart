import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/restaurant_card.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';
import '../../config/colors.dart';
import '../widgets/noteEtoile.dart';
import '../../models/restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: DatabaseProvider.getAllRestaurants(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List<Restaurant> data = snapshot.data!;
            var restaus = [];
            for (var i = 0; i <= 4; i++) {
              var intValue = Random().nextInt(25);
              restaus.add(data[intValue]);
            }
            print([for(var i in restaus) i]);
            return PickMenuScaffold(
              child: Expanded(
                child: ListView.builder(
                  itemCount: restaus.length,
                  itemBuilder: (context, index) {
                    return RestaurantCard(restau: restaus[index]);
                  },
                ),
              )
            );
        }
      },
    );
  }
}
