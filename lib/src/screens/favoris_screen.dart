import 'package:flutter/material.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/restaurant_card.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';
import '../../config/colors.dart';
import '../../config/router.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  bool _isLoading = true;
  List<Restaurant> _favoriteRestaurants = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final restaurants = await DatabaseProvider.getFavoriteRestaurants();
      setState(() {
        _favoriteRestaurants = restaurants;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Impossible de charger les favoris : ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PickMenuScaffold(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadFavorites,
              child: const Text("Réessayer"),
            ),
          ],
        ),
      )
          : _favoriteRestaurants.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 80,
              color: PickMenuColors.iconsColor,
            ),
            const SizedBox(height: 20),
            const Text(
              "Vous n'avez pas encore de restaurants favoris",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                router.go('/home');
              },
              child: const Text("Découvrir des restaurants"),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadFavorites,
        child: ListView.builder(
          itemCount: _favoriteRestaurants.length,
          itemBuilder: (context, index) {
            return RestaurantCard(
                restau: _favoriteRestaurants[index]);
          },
        ),
      ),
    );
  }
}