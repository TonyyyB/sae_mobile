import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

import '../../config/colors.dart';

class FavoriteWidget extends StatefulWidget {
  final int _idRestau;
  FavoriteWidget({super.key, required int idRestau}): this._idRestau = idRestau;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState(idRestau : _idRestau);
  }

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _idRestau;

   _FavoriteWidgetState({required int idRestau}):
    this._idRestau = idRestau;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
        DatabaseProvider.addFavoriRestaurant(this._idRestau);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            icon: (_isFavorited
                ? const Icon(IconData(0xe25b, fontFamily: 'MaterialIcons'))
                : const Icon(IconData(0xe25c, fontFamily: 'MaterialIcons'))),
            color: PickMenuColors.textFieldErrorBorder,
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
            width: 18,
        ),
      ],
    );
  }
}