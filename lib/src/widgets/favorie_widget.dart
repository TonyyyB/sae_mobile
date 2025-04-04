import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

import '../../config/colors.dart';

class FavoriteWidget extends StatefulWidget {
  final int idRestau;
  const FavoriteWidget({super.key, required this.idRestau});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
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
    setState(() {
      _isLoading = true;

      if (_isFavorited) {
        _isFavorited = false;
        DatabaseProvider.removeFavoriRestaurant(widget.idRestau);
      } else {
        _isFavorited = true;
        DatabaseProvider.addFavoriRestaurant(widget.idRestau);
      }
    });

    String? error;
    if (_isFavorited) {
      error = await DatabaseProvider.removeFavoriRestaurant(widget.idRestau);
    } else {
      error = await DatabaseProvider.addFavoriRestaurant(widget.idRestau);
    }

    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (mounted) {
      setState(() {
        _isFavorited = !_isFavorited;
      });
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
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
