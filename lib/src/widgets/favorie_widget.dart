import 'package:flutter/material.dart';

import '../../config/colors.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;


  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
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