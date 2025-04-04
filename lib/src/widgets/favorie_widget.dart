import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

import '../../config/colors.dart';

class FavoriteWidget extends StatefulWidget {
  final int idRestau;
  FavoriteWidget({super.key, required this.idRestau});

  @override
  State<FavoriteWidget> createState()=>_FavoriteWidgetState();
  }

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    loadData().then((value) {
      if(value) {
        setState(() {
          _isFavorited = true;
        });
      }
    },);
  }

  Future<bool> loadData() async{
    return await DatabaseProvider.isRestaurantFavori(widget.idRestau);
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        DatabaseProvider.removeFavoriRestaurant(widget.idRestau);
      } else {
        _isFavorited = true;
        DatabaseProvider.addFavoriRestaurant(widget.idRestau);
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