import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/models/avis.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/widgets/avis.dart';
import 'package:sae_mobile/src/widgets/noteEtoile.dart';

class AvisRestaurant extends StatefulWidget {
  final Restaurant restaurant;
  const AvisRestaurant({super.key, required this.restaurant});

  @override
  State<AvisRestaurant> createState() => _AvisRestaurantState();
}

class _AvisRestaurantState extends State<AvisRestaurant> {
  bool _isSubmitting = false;
  int _note = 5;
  final TextEditingController _commentaireController = TextEditingController();
  void sendAvis() async {
    final commentaire = _commentaireController.text.trim();
    setState(() {
      _isSubmitting = true;
    });
    try {
      Avis avis = Avis(
          restaurant: widget.restaurant,
          uuid: DatabaseProvider.getUser()!.id,
          commentaire: commentaire,
          note: _note);
      final err = await DatabaseProvider.postAvisRestaurant(avis, null);
      if (err != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Une erreur est survenue : $err")),
        );
      } else {
        widget.restaurant.addAvis(avis);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Une erreur est survenue : $e")),
      );
    }
    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
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
                      widget.restaurant.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: NoteEtoile(
                          rating: widget.restaurant.avis == null
                              ? 0
                              : (widget.restaurant.avis!
                                      .fold(0, (total, e) => total + e.note)) /
                                  widget.restaurant.avis!.length)),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1.5,
                    color: Theme.of(context).textTheme.headlineMedium!.color,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: widget.restaurant.avis == null
                    ? Text("Aucun avis pour le moment",
                        style: Theme.of(context).textTheme.headlineLarge)
                    : ListView.builder(
                        itemCount: widget.restaurant.avis!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: AvisWidget(
                                avis: widget.restaurant.avis![index]),
                          );
                        },
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
                    //children: [const Text("Note: "), NoteEtoile(rating: 5)],
                    children: [
                      const Text("Note: "),
                      ElevatedButton(
                          onPressed: () {
                            _note = 1;
                          },
                          child: const Text("1")),
                      ElevatedButton(
                          onPressed: () {
                            _note = 2;
                          },
                          child: const Text("2")),
                      ElevatedButton(
                          onPressed: () {
                            _note = 3;
                          },
                          child: const Text("3")),
                      ElevatedButton(
                          onPressed: () {
                            _note = 4;
                          },
                          child: const Text("4")),
                      ElevatedButton(
                          onPressed: () {
                            _note = 5;
                          },
                          child: const Text("5")),
                    ],
                  ),
                  TextField(
                    controller: _commentaireController,
                    decoration: InputDecoration(hintText: "Commentaire"),
                    maxLines: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: _isSubmitting
                          ? null
                          : () {
                              sendAvis();
                            },
                      child: _isSubmitting
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text("Envoyer"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
