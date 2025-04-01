import 'package:flutter/material.dart';
import 'package:sae_mobile/src/widgets/avis.dart';
import 'package:sae_mobile/src/widgets/avis_restaurant.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';

class AvisScreen extends StatelessWidget {
  final String id;
  const AvisScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return PickMenuScaffold(child: AvisRestaurant());
  }
}
