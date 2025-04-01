import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/src/widgets/noteEtoile.dart';

class AvisWidget extends StatelessWidget {
  const AvisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Josiane D",
                      style: Theme.of(context).textTheme.bodyLarge)),
              Align(
                  alignment: Alignment.centerRight,
                  child: NoteEtoile(rating: 4)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sed nulla tortor. Vivamus vestibulum nibh ut elit porttitor, sed sollicitudin libero feugiat. Nunc vestibulum, libero a maximus suscipit, tortor libero consectetur augue, vestibulum aliquam erat orci eu turpis. Praesent vitae nisl sed ex bibendum aliquet ut sed dolor. Donec ut risus euismod, mollis arcu sed, molestie nulla. Sed finibus orci dignissim consequat cursus. Donec eu vestibulum velit. Pellentesque efficitur sollicitudin diam, et condimentum massa. Ut at libero consequat, efficitur elit non, pulvinar nibh. Etiam congue imperdiet felis, nec iaculis leo facilisis ac. Nam efficitur ut risus at laoreet. Nullam felis sapien, scelerisque eu tellus vitae, imperdiet volutpat enim. Ut at ipsum varius, faucibus felis ac, imperdiet ligula. Sed at molestie nisl.",
                  style: PickMenuTheme.spanTextStyle(),
                )),
          )
        ],
      ),
    );
  }
}
