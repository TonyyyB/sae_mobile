import 'package:flutter/material.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/favorite_cuisine_widget.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';
import '../../config/colors.dart';
import '../../config/router.dart';

class FavorisCuisineScreen extends StatefulWidget {
  const FavorisCuisineScreen({super.key});

  @override
  State<FavorisCuisineScreen> createState() => _FavorisCuisineScreenState();
}

class _FavorisCuisineScreenState extends State<FavorisCuisineScreen> {
  bool _isLoading = true;
  List<String> _favoriteCuisine = [];
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
      final cuisines = await DatabaseProvider.getFavorisCuisines();
      setState(() {
        _favoriteCuisine = cuisines;
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
              : _favoriteCuisine.isEmpty
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
                            "Vous n'avez pas encore de type de cuisine favoris",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              router.go('/home');
                            },
                            child: const Text("Découvrir des type de cuisine"),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadFavorites,
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.fromLTRB(50, 40, 50, 10),
                        child: Column(
                          children: [
                            const Text(
                              "Voici vos types de cuisines favoris: ",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            Column(
                              children: _favoriteCuisine
                                  .map((e) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Text('\t\t- $e',
                                              style: PickMenuTheme
                                                  .detailTextStyle()),
                                          FavoriteCuisineWidget(nomStyle: e)
                                        ],
                                      )))
                                  .toList(),
                            ),
                          ],
                        ),
                      )),
    );
  }
}
