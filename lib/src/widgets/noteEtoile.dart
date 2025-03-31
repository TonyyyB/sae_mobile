import 'package:flutter/material.dart';
import '../../config/colors.dart';

const Icon star = Icon(
    color: PickMenuColors.iconsColor,
    IconData(0xe5f9, fontFamily: 'MaterialIcons'));
const Icon star_empty = Icon(
    color: PickMenuColors.iconsColor,
    IconData(0xe5fa, fontFamily: 'MaterialIcons'));

class SingleRatingIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color iconColor;
  final double rating;

  const SingleRatingIcon(
      {super.key,
      required this.icon,
      required this.size,
      required this.iconColor,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [0, rating / 1, rating / 1],
          colors: [iconColor, iconColor, iconColor.withOpacity(0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child:
            Icon(icon, size: size, color: PickMenuColors.inputDisabledBorder),
      ),
    );
  }
}

class NoteEtoile extends StatelessWidget {
  final double size;
  final Color iconColor;
  final double rating;

  NoteEtoile(
      {super.key,
      this.size = 20,
      this.iconColor = PickMenuColors.iconsColor,
      required this.rating});
  @override
  Widget build(BuildContext context) {
    double cpt = rating;
    Row res = Row(children: <Widget>[]);
    for (var i = 0; i < 5; i++) {
      if (cpt >= 1) {
        res.children.add(Icon(
            color: iconColor,
            size: size,
            IconData(0xe5f9, fontFamily: 'MaterialIcons')));
        cpt--;
      } else if (cpt > 0) {
        res.children.add(SingleRatingIcon(
            icon: Icons.star,
            size: size,
            iconColor: PickMenuColors.iconsColor,
            rating: cpt));
        cpt = 0;
      } else if (cpt == 0) {
        res.children.add(Icon(
            color: PickMenuColors.inputDisabledBorder,
            size: size,
            IconData(0xe5f9, fontFamily: 'MaterialIcons')));
      }
    }

    return res;
  }
}
