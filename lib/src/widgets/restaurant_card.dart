import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sae_mobile/config/router.dart';
import 'package:sae_mobile/src/widgets/favorie_widget.dart';
import 'package:sae_mobile/src/widgets/noteEtoile.dart';
import '../../config/colors.dart';
import '../../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant _restaurant;
  final double? note;

  const RestaurantCard({super.key, required Restaurant restau, this.note})
      : this._restaurant = restau;

  @override
  Widget build(BuildContext context) {
    var typeCuisine = _restaurant.parseCuisine;
    typeCuisine ??= "Type de cuisine non spécifié";
    var horaires = _restaurant.parseOpeningHours;
    horaires ??= "      Horaires indisponibles";
    return Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.fromLTRB(50, 40, 50, 10),
        child: GestureDetector(
          onTap: () {
            router.push("/detail/${_restaurant.osmId}");
          },
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(width: 2.0, color: PickMenuColors.textColor),
                  ),
                ),
                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(_restaurant.name,
                                style: TextStyle(
                                    color: PickMenuColors.textColor,
                                    fontSize: 24))),
                        Align(
                            alignment: Alignment.centerRight,
                            child: NoteEtoile(
                                rating: this.note ?? _restaurant.getGlobalRate))
                      ]),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
                            child: Text(_restaurant.type,
                                style: TextStyle(
                                    color: PickMenuColors.inputHint,
                                    fontSize: 16)))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                                'Type de cuisine : \n      $typeCuisine',
                                style: TextStyle(
                                    color: PickMenuColors.inputHint,
                                    fontSize: 16)))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text("Horaires d'ouverture : \n$horaires",
                                style: TextStyle(
                                    color: PickMenuColors.inputHint,
                                    fontSize: 16)))),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                            padding: EdgeInsets.all(16),
                            child:
                                FavoriteWidget(idRestau: _restaurant.osmId))),
                  ])),
            ],
          ),
        ));
  }
}
