import 'package:flutter/material.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/models/avis.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

class DetailsScreen extends StatefulWidget {
  final String restaurantId;

  const DetailsScreen({super.key, required this.restaurantId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Restaurant? restaurant;
  List<Avis> avisList = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchRestaurantDetails();
  }

  Future<void> fetchRestaurantDetails() async {
    try {
      int id = int.tryParse(widget.restaurantId) ?? -1;
      if (id == -1) throw Exception("ID de restaurant invalide");

      // Récupérer le restaurant
      Restaurant? fetchedRestaurant = await DatabaseProvider.getRestaurantById(id);
      if (fetchedRestaurant == null) {
        setState(() {
          errorMessage = "Restaurant introuvable";
          isLoading = false;
        });
        return;
      }

      // Récupérer les avis du restaurant
      List<Avis> fetchedAvis = await DatabaseProvider.getAvisRestaurant(fetchedRestaurant);

      setState(() {
        restaurant = fetchedRestaurant;
        avisList = fetchedAvis;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Erreur lors du chargement : ${e.toString()}";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Chargement..."), backgroundColor: Colors.green),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: Text("Erreur"), backgroundColor: Colors.red),
        body: Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant!.name),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurant!.name, style: PickMenuTheme.defaultTheme().textTheme.headlineLarge),
            SizedBox(height: 10),
            Text("Type: ${restaurant!.type}"),
            Text("Région: ${restaurant!.region}, Département: ${restaurant!.departement}, Commune: ${restaurant!.commune}"),
            if (restaurant!.phone != null) Text("Téléphone: ${restaurant!.phone}"),
            if (restaurant!.website != null)
              Text("Site Web: ${restaurant!.website}", style: TextStyle(color: Colors.blue)),
            SizedBox(height: 20),
            Text("Options:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text((restaurant!.vegetarian ?? false) ? "✔ Végétarien" : "✖ Végétarien"),
            Text((restaurant!.vegan ?? false) ? "✔ Végan" : "✖ Végan"),
            Text((restaurant!.delivery ?? false) ? "✔ Livraison" : "✖ Livraison"),
            Text((restaurant!.takeaway ?? false) ? "✔ À emporter" : "✖ À emporter"),
            SizedBox(height: 20),
            Text("Avis:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: avisList.isNotEmpty
                  ? ListView.builder(
                itemCount: avisList.length,
                itemBuilder: (context, index) {
                  Avis avis = avisList[index];
                  return ListTile(
                    title: Text("Note: ${avis.note}/5"),
                    subtitle: Text(avis.commentaire ?? "Pas de commentaire"),
                  );
                },
              )
                  : Center(child: Text("Aucun avis disponible.")),
            ),
          ],
        ),
      ),
    );
  }
}
