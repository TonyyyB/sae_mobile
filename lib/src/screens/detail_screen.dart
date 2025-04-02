import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/models/avis.dart';
import 'package:sae_mobile/config/colors.dart';
import '../data/database_provider.dart';
import '../widgets/scaffold.dart';



class DetailsScreen extends StatefulWidget {
  final int restaurantId;

  const DetailsScreen({super.key, required this.restaurantId});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant?>(
    future: DatabaseProvider.getRestaurantById(widget.restaurantId, loadAvis: true),
    builder: (context, snapshot) {
      Widget child = Text(
        "Le restaurant d'id ${widget.restaurantId} n'existe pas !",
        style: Theme.of(context).textTheme.bodyLarge,
      );
      if (snapshot.connectionState == ConnectionState.waiting) {
        child = CircularProgressIndicator();
      } else if (snapshot.hasError) {
        child = Text(
          "Une erreur s'est produite: ${snapshot.error}",
          style: Theme.of(context).textTheme.bodyLarge,
        );
      }

      else if (snapshot.hasData) {
        Restaurant restaurant = snapshot.data!;
        child = SingleChildScrollView(
            child: Column(
              children: [
                _buildRestaurantInfo(restaurant),
                _buildRestaurantMap(restaurant),
                _buildAvisSection(restaurant),
                _buildVoirPlusButton(),
              ],
            ),
        );
      }
      return PickMenuScaffold(child: child);
      },
    );
  }

  Widget _buildRestaurantInfo(Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name ?? 'Nom non disponible',
            style: Theme.of(context).textTheme.headlineMedium,  // Custom text style from theme
          ),
          SizedBox(height: 8),
          Text(
            'Type: ${restaurant.type ?? 'Non renseigné'}',
            style: Theme.of(context).textTheme.titleMedium,  // Custom text style from theme
          ),
          SizedBox(height: 8),
          Text(
            'Cuisine: ${restaurant.cuisine?.join(", ") ?? 'Non renseignée'}',
            style: Theme.of(context).textTheme.titleMedium,  // Custom text style from theme
          ),
          SizedBox(height: 8),
          Text(
            'Localisation: ${restaurant.region}, ${restaurant.departement}, ${restaurant.commune}',
            style: Theme.of(context).textTheme.titleMedium,  // Custom text style from theme
          ),
          SizedBox(height: 8),
          _buildOpeningHours(restaurant),
        ],
      ),
    );
  }


  Widget _buildOpeningHours(Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (restaurant.openingHours != null)
            ...restaurant.openingHours!.map((jour) => Text(jour!)).toList()
          else
            Text('Aucune horaires disponible'),
        ]
    );
  }


  Widget _buildRestaurantMap(Restaurant restaurant) {
    return Container(
      height: 250,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(restaurant.latitude ?? 0.0, restaurant.longitude ?? 0.0),
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(restaurant.osmId.toString()),
            position: LatLng(restaurant.latitude ?? 0.0, restaurant.longitude ?? 0.0),
            infoWindow: InfoWindow(title: restaurant.name ?? 'Restaurant'),
          ),
        },
      ),
    );
  }


  Widget _buildAvisSection(Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Avis',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          if (restaurant.avis != null) ...[
            if(restaurant.avis!.length == 1)...[
              _buildAvisItem(restaurant.avis![0])
            ] else if (restaurant.avis!.length > 1)...[
              _buildAvisItem(restaurant.avis![0]),
              _buildAvisItem(restaurant.avis![1]),
            ]

          ] else ...[
            Text('Aucun avis disponible'),
          ],
        ],
      ),
    );
  }


  Widget _buildAvisItem(Avis avis) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text('${avis.note ?? 0}', style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 8),
              Text(avis.commentaire ?? 'Aucun commentaire'),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildVoirPlusButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          //Navigator.push(
          //context,
          //MaterialPageRoute(
          //builder: (context) => AvisScreen(restaurant: Restaurant),
          //),
          // );
        },
        child: Text('Voir plus d\'avis', style: Theme.of(context).textTheme.bodyMedium,))
  );
  }
}

