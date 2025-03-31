import 'package:flutter/material.dart';
import '../../config/colors.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(50.0),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Click')));
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
                  child: Row(children: [
                    const Text('Nom du restau',
                        style: TextStyle(
                            color: PickMenuColors.textColor, fontSize: 24))
                  ]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Mo : 8h-12h 14h-18h\nMo : 8h-12h 14h-18h\nMo : 8h-12h 14h-18h\nMo : 8h-12h 14h-18h\nMo : 8h-12h 14h-18h\n',
                  style:
                      TextStyle(color: PickMenuColors.inputHint, fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}
