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
  double? noteGlobale;

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

      // Récupérer la note globale
      double? fetchedNote = await DatabaseProvider.getRestaurantNote(fetchedRestaurant);

      setState(() {
        restaurant = fetchedRestaurant;
        avisList = fetchedAvis;
        noteGlobale = fetchedNote;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Erreur lors du chargement : ${e.toString()}";
        isLoading = false;
      });
    }
  }

  Widget _buildStarRating(double? rating, {double size = 24.0}) {
    if (rating == null) return Row();

    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        ...List.generate(
            fullStars,
                (index) => Icon(Icons.star, color: Colors.amber, size: size)
        ),
        if (hasHalfStar) Icon(Icons.star_half, color: Colors.amber, size: size),
        ...List.generate(
            emptyStars,
                (index) => Icon(Icons.star_border, color: Colors.amber, size: size)
        ),
      ],
    );
  }

  Widget _buildHorairesSection() {
    List<String>? openingHours = restaurant?.getOpeningHours;
    if (openingHours == null || openingHours.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Horaires d'ouverture :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...openingHours.map((horaire) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Text(horaire),
        )).toList(),
      ],
    );
  }

  Widget _buildOptionsSection() {
    List<Widget> options = [];

    if (restaurant?.getVegetarian == true) {
      options.add(const Text("• Végétarien"));
    }

    if (restaurant?.getVegan == true) {
      options.add(const Text("• Végan"));
    }

    if (restaurant?.getWheelchair == true) {
      options.add(const Text("• Accès fauteuil roulant"));
    }

    if (restaurant?.getDelivery == true) {
      options.add(const Text("• Livraison"));
    }

    if (restaurant?.getTakeaway == true) {
      options.add(const Text("• À emporter"));
    }

    if (restaurant?.getDriveThrough == true) {
      options.add(const Text("• Service au volant"));
    }

    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Options disponibles :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...options.map((option) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: option,
        )).toList(),
      ],
    );
  }

  Widget _buildContactSection() {
    List<Widget> contactInfo = [];

    if (restaurant?.getphone != null) {
      contactInfo.add(Text(restaurant!.getphone!));
    }

    if (restaurant?.getWebsite != null) {
      contactInfo.add(Text(restaurant!.getWebsite!,
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)));
    }

    if (restaurant?.getFacebook != null) {
      contactInfo.add(Text(restaurant!.getFacebook!,
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)));
    }

    if (contactInfo.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...contactInfo.map((info) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: info,
        )).toList(),
      ],
    );
  }

  Widget _buildAvisSection() {
    if (avisList.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Avis :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Center(child: Text("Aucun avis disponible.")),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Important pour éviter que la colonne prenne tout l'espace
      children: [
        const Text(
          "Avis :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        // Limiter le nombre d'avis affichés ou utiliser un Container à hauteur fixe
        Container(
          height: 200, // Hauteur fixe pour la liste d'avis
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: avisList.length,
            itemBuilder: (context, index) {
              Avis avis = avisList[index];
              return ListTile(
                title: Row(
                  children: [
                    Text(
                      avis.uuid.split('-').first,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    _buildStarRating(avis.note.toDouble(), size: 16),
                  ],
                ),
                subtitle: avis.commentaire != null
                    ? Text(avis.commentaire!)
                    : null,
              );
            },
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              // Action pour voir plus d'avis
            },
            child: const Text("Voir plus d'avis >"),
          ),
        ),
      ],
    );
  }

  Widget _buildCuisineSection() {
    List<String>? cuisines = restaurant?.getCuisine;
    if (cuisines == null || cuisines.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Type de cuisine :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(cuisines.join(", ")),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Le trouver :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Placeholder pour la carte
                const Text("Carte en chargement..."),
                // Marqueur pour le restaurant
                Icon(
                  Icons.location_on,
                  color: Colors.red.shade700,
                  size: 36,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Chargement..."), backgroundColor: Colors.green),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Erreur"), backgroundColor: Colors.red),
        body: Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant!.getName),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () async {
              await DatabaseProvider.addFavoriRestaurant(restaurant!.getOsmId);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ajouté aux favoris"))
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  restaurant!.getName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStarRating(noteGlobale),
              ],
            ),
            const SizedBox(height: 8),
            Text(restaurant!.getType),
            const SizedBox(height: 16),
            _buildCuisineSection(),
            const SizedBox(height: 16),
            _buildHorairesSection(),
            const SizedBox(height: 16),
            _buildOptionsSection(),
            const SizedBox(height: 16),
            _buildContactSection(),
            const SizedBox(height: 16),
            _buildAvisSection(),
            const SizedBox(height: 24),
            _buildLocationSection(),
          ],
        ),
      ),
    );
  }
}