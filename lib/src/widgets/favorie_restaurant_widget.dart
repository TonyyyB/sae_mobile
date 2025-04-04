import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

import '../../config/colors.dart';

class FavoriteRestaurantWidget extends StatefulWidget {
  final int idRestau;
  const FavoriteRestaurantWidget({super.key, required this.idRestau});

  @override
  State<FavoriteRestaurantWidget> createState() =>
      _FavoriteRestaurantWidgetState();
}

class _FavoriteRestaurantWidgetState extends State<FavoriteRestaurantWidget> {
  bool _isFavorited = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData().then(
      (value) {
        if (value) {
          setState(() {
            _isFavorited = true;
          });
        }
      },
    );
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite =
        await DatabaseProvider.isRestaurantFavorite(widget.idRestau);

    if (mounted) {
      setState(() {
        _isFavorited = isFavorite;
        _isLoading = false;
      });
    }
  }

  Future<bool> loadData() async {
    return await DatabaseProvider.isRestaurantFavori(widget.idRestau);
  }

  void _toggleFavorite() async {
    String? error;
    setState(() {
      _isLoading = true;
    });
    if (_isFavorited) {
      _isFavorited = false;
      error = await DatabaseProvider.removeFavoriRestaurant(widget.idRestau);
    } else {
      _isFavorited = true;
      error = await DatabaseProvider.addFavoriRestaurant(widget.idRestau);
    }

    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (mounted) {
      _checkFavoriteStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: PickMenuColors.textFieldErrorBorder,
                  ),
                )
              : IconButton(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  icon: (_isFavorited
                      ? const Icon(
                          IconData(0xe25b, fontFamily: 'MaterialIcons'))
                      : const Icon(
                          IconData(0xe25c, fontFamily: 'MaterialIcons'))),
                  color: PickMenuColors.textFieldErrorBorder,
                  onPressed: _toggleFavorite,
                ),
        ),
        const SizedBox(
          width: 18,
        ),
      ],
    );
  }
}
