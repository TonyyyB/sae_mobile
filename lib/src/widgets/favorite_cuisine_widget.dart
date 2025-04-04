import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

import '../../config/colors.dart';

class FavoriteCuisineWidget extends StatefulWidget {
  final String nomStyle;
  const FavoriteCuisineWidget({super.key, required this.nomStyle});

  @override
  State<FavoriteCuisineWidget> createState() => _FavoriteCuisineWidgetState();
}

class _FavoriteCuisineWidgetState extends State<FavoriteCuisineWidget> {
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
        await DatabaseProvider.isCuisineFavorite(widget.nomStyle);

    if (mounted) {
      setState(() {
        _isFavorited = isFavorite;
        _isLoading = false;
      });
    }
  }

  Future<bool> loadData() async {
    return await DatabaseProvider.isCuisineFavorite(widget.nomStyle);
  }

  void _toggleFavorite() async {
    String? error;
    setState(() {
      _isLoading = true;
    });
    if (_isFavorited) {
      _isFavorited = false;
      error = await DatabaseProvider.removeCuisineFavorite(widget.nomStyle);
    } else {
      _isFavorited = true;
      error = await DatabaseProvider.addCuisineFavorite(widget.nomStyle);
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
