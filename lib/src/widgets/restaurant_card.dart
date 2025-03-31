import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant _restaurant;

  const RestaurantCard({super.key, required Restaurant restau}):
    this._restaurant = restau;


  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            margin : EdgeInsets.all(50.0),
            child: GestureDetector(
            onTap : (){ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Click')));},
            child :Column(
              children: [ Container(
                decoration: const BoxDecoration(
                  border : Border(
                    bottom: BorderSide(width: 2.0, color: PickMenuColors.textColor),
                  ),
                ),
                margin : EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Padding(
                  padding : const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child : Row(
                      children :[Text(_restaurant.getName, style: TextStyle(color: PickMenuColors.textColor, fontSize: 24))
                      ]
                  ),
                ),
              ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    _restaurant.parseOpeningHours,
                    style: TextStyle(color: PickMenuColors.inputHint, fontSize : 16),
                  ),
                ),
              ],
            ),
          ));
  }
}

