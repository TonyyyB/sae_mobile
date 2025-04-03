import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:sae_mobile/config/router.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/models/avis.dart';
import 'package:sae_mobile/src/widgets/avis.dart';
import 'package:sae_mobile/src/widgets/noteEtoile.dart';
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
      future: DatabaseProvider.getRestaurantById(widget.restaurantId,
          loadAvis: true),
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
        } else if (snapshot.hasData) {
          Restaurant restaurant = snapshot.data!;
          child = SingleChildScrollView(
            child: Card(
              elevation: 10,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.fromLTRB(50, 40, 50, 10),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            restaurant.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: NoteEtoile(
                                rating: restaurant.avis == null
                                    ? 0
                                    : (restaurant.avis!.fold(
                                            0, (total, e) => total + e.note)) /
                                        restaurant.avis!.length)),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 1.5,
                          color:
                              Theme.of(context).textTheme.headlineMedium!.color,
                        )),
                    _buildRestaurantInfo(restaurant),
                    _buildRestaurantMap(restaurant),
                  ],
                ),
              ),
            ),
          );
        }
        return PickMenuScaffold(child: child);
      },
    );
  }

  Widget _buildRestaurantInfo(Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.type,
            style: PickMenuTheme.detailTextStyle(),
          ),
          SizedBox(height: 8),
          // Type de cuisine
          Text("Types de cuisine :",
              style: PickMenuTheme.detailTitleTextStyle()),
          Text(
              restaurant.cuisine == null
                  ? '\t\tNon renseigné'
                  : restaurant.cuisine!.isEmpty
                      ? '\t\tNon renseigné'
                      : '\t\t${restaurant.cuisine?.join(", ")}',
              style: PickMenuTheme.detailTextStyle()),
          SizedBox(height: 8),
          // Horaires d'ouverture
          Text("Horaires d'ouverture :",
              style: PickMenuTheme.detailTitleTextStyle()),
          _buildOpeningHours(restaurant),
          SizedBox(height: 8),
          // Options
          Text("Option disponibles :",
              style: PickMenuTheme.detailTitleTextStyle()),
          _buildOptions(restaurant),
          SizedBox(height: 8),
          // Contact
          Text("Contact :", style: PickMenuTheme.detailTitleTextStyle()),
          _buildContact(restaurant),
          SizedBox(height: 8),
          // Avis
          Text("Avis :", style: PickMenuTheme.detailTitleTextStyle()),
          _buildAvisSection(restaurant),
          SizedBox(height: 8)
        ],
      ),
    );
  }

  Widget _buildOptions(Restaurant restaurant) {
    final Map<String, bool?> options = {
      "Végétarien": restaurant.vegetarian,
      "Végan": restaurant.vegan,
      "Livraison": restaurant.delivery,
      "Accès fauteil roulant": restaurant.wheelchair,
      "Click&Collect": restaurant.takeaway,
      "Drive": restaurant.driveThrough
    };
    options.removeWhere((k, v) => v == null || v == false);
    if (options.isEmpty) {
      return Text(
        "\t\tAucune option n'est disponnible",
        style: PickMenuTheme.detailTextStyle(),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: options.entries
          .map((e) => Align(
              alignment: Alignment.centerLeft,
              child: Text('\t\t- ${e.key}',
                  style: PickMenuTheme.detailTextStyle())))
          .toList(),
    );
  }

  Widget _buildContact(Restaurant restaurant) {
    final Map<String, String?> contact = {
      "Téléphone": restaurant.phone,
      "Site web": restaurant.website,
      "Facebook": restaurant.facebook
    };
    contact.removeWhere((k, v) => v == null || v.isEmpty);
    if (contact.isEmpty) {
      return Text(
        "\t\tAucun contact n'est disponnible",
        style: PickMenuTheme.detailTextStyle(),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: contact.entries
          .map((e) => Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '\t\t- ${e.key} : ',
                    style: PickMenuTheme.detailTextStyle()),
                TextSpan(
                    text: e.value,
                    style: PickMenuTheme.detailClickableTextStyle())
              ]))))
          .toList(),
    );
  }

  Widget _buildOpeningHours(Restaurant restaurant) {
    if (restaurant.openingHours == null) {
      return Text("Aucun horraire disponnible",
          style: PickMenuTheme.detailTextStyle());
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: restaurant.openingHours!
          .map((e) => Align(
              alignment: Alignment.centerLeft,
              child: Text('\t\t${e ?? "Fermé"}',
                  style: PickMenuTheme.detailTextStyle())))
          .toList(),
    );
  }

  Widget _buildRestaurantMap(Restaurant restaurant) {
    return Container(
      height: 500,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(restaurant.latitude, restaurant.longitude),
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            tileProvider: CancellableNetworkTileProvider(),
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(restaurant.latitude, restaurant.longitude),
                width: 40,
                height: 40,
                child:
                    const Icon(Icons.location_pin, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvisSection(Restaurant restaurant) {
    Widget content = Text("\t\tAucun avis pour le moment",
        style: PickMenuTheme.detailTextStyle());
    if (restaurant.avis != null) {
      List<Avis> avis = [restaurant.avis![0]];
      if (restaurant.avis!.length > 1) {
        avis.add(restaurant.avis![1]);
      }
      content = Column(
        children: avis
            .map((e) => Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AvisWidget(avis: e),
                )))
            .toList(),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: content,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RichText(
            text: TextSpan(
                text: "Voir plus d'avis >",
                style: PickMenuTheme.detailClickableTextStyle(),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    router.push("/detail/${restaurant.osmId}/avis");
                  }),
          ),
        )
      ],
    );
  }
}
