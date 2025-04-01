import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/src/widgets/avis.dart';
import 'package:sae_mobile/src/widgets/noteEtoile.dart';

class AvisRestaurant extends StatelessWidget {
  const AvisRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(50.0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Cha+",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: NoteEtoile(rating: 4)),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1.5,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: AvisWidget(),
                    );
                  },
                ),
              ),
            ),
            Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Ajouter votre avis :",
                      style: PickMenuTheme.importantTextStyle()),
                ),
                Row(
                  children: [const Text("Note : "), NoteEtoile(rating: 1)],
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Commentaire"),
                  maxLines: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Enregistrer")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
