import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';

const double _note = 0.0;

const Icon star = Icon(color:PickMenuColors.iconsColor, IconData(0xe5f9, fontFamily: 'MaterialIcons'));
const Icon star_empty = Icon(color:PickMenuColors.iconsColor,IconData(0xe5fa, fontFamily: 'MaterialIcons'));
const Icon icon = star_empty;

class EtoileButtons extends StatefulWidget {
  const EtoileButtons({super.key, this.note = _note});
  final double note;
  @override
  State<EtoileButtons> createState() => _EtoileButtonsState();
}

class _EtoileButtonsState extends State<EtoileButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: icon,
          tooltip: 'Note 1',
          onPressed: () {
            setState(() {
              _note = 1;
            });
          },
        ),
        IconButton(
          icon: icon,
          tooltip: 'Note 2',
          onPressed: () {
            setState(() {
              _note = 2;
            });
          },
        ),
        IconButton(
          icon: icon,
          tooltip: 'Note 3',
          onPressed: () {
            setState(() {
              _note = 3;
            });
          },
        ),
        IconButton(
          icon: icon,
          tooltip: 'Note 4',
          onPressed: () {
            setState(() {
              _note = 4;
            });
          },
        ),
        IconButton(
          icon: icon,
          tooltip: 'Note 5',
          onPressed: () {
            setState(() {
              _note = 5;
            });
          },
        ),
        Text('Note : $_note'),
      ],
    );
  }
}