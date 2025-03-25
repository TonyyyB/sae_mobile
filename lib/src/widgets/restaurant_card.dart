import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/colors.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
            clipBehavior: Clip.antiAlias,
            margin : EdgeInsets.all(50.0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border : Border(
                      bottom: BorderSide(width: 2.0, color: PickMenuColors.textColor),
                    ),
                  ),
                  margin : EdgeInsets.fromLTRB(40, 20, 40, 20),
                  child: Padding(
                      padding : const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child : Row(
                        children :[TextButton(onPressed: () {}, child: const Text('Nom du restau', style: TextStyle(color: PickMenuColors.textColor, fontSize: 24)))
                          ]
                      ),
                  ),
                  ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Les horaires',
                    style: TextStyle(color: PickMenuColors.inputHint),
                  ),
                ),

              ],
            ),
          );
  }
}

