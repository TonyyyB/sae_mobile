import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/models/avis.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/noteEtoile.dart';

class AvisWidget extends StatelessWidget {
  final Avis avis;
  const AvisWidget({super.key, required this.avis});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(String, String)?>(
      future: DatabaseProvider.getNomPrenom(avis.uuid),
      builder: (context, snapshot) {
        Widget nameWidget = Text(
          "Anonyme",
          style: Theme.of(context).textTheme.bodyLarge,
        );
        if (snapshot.connectionState == ConnectionState.waiting) {
          nameWidget = CircularProgressIndicator();
        } else if (snapshot.hasError) {
          nameWidget = Text(
            snapshot.error.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          final String nom = data.$2;
          final String prenom = data.$1;
          nameWidget = Text("$nom ${prenom[0].toUpperCase()}.",
              style: Theme.of(context).textTheme.bodyLarge);
        }
        return SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: nameWidget,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: NoteEtoile(rating: avis.note as double)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      avis.commentaire ?? "",
                      style: PickMenuTheme.detailTextStyle(),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
