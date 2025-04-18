import 'package:flutter/material.dart';

import '../../config/colors.dart';

const Icon star = Icon(
    color: PickMenuColors.iconsColor,
    IconData(0xe5f9, fontFamily: 'MaterialIcons'));
const Icon star_empty = Icon(
    color: PickMenuColors.iconsColor,
    IconData(0xe5fa, fontFamily: 'MaterialIcons'));

class EtoileButtons extends StatefulWidget {
  final Function(double newValue)? onNoteChange;
  double _note;
  EtoileButtons({super.key, this.onNoteChange, double note = 0}) : _note = note;

  @override
  State<EtoileButtons> createState() => EtoileButtonsState();

  get note => _note;

  set note(note) {
    _note = note;
    if (onNoteChange != null) onNoteChange!(_note);
  }
}

class EtoileButtonsState extends State<EtoileButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: widget.note >= 1 ? star : star_empty,
          tooltip: 'Note 1',
          onPressed: () {
            setState(() {
              widget.note = 1;
            });
          },
        ),
        IconButton(
          icon: widget.note >= 2 ? star : star_empty,
          tooltip: 'Note 2',
          onPressed: () {
            setState(() {
              widget.note = 2;
            });
          },
        ),
        IconButton(
          icon: widget.note >= 3 ? star : star_empty,
          tooltip: 'Note 3',
          onPressed: () {
            setState(() {
              widget.note = 3;
            });
          },
        ),
        IconButton(
          icon: widget.note >= 4 ? star : star_empty,
          tooltip: 'Note 4',
          onPressed: () {
            setState(() {
              widget.note = 4;
            });
          },
        ),
        IconButton(
          icon: widget.note >= 5 ? star : star_empty,
          tooltip: 'Note 5',
          onPressed: () {
            setState(() {
              widget.note = 5;
            });
          },
        ),
      ],
    );
  }
}
