import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sae_mobile/config/colors.dart';
import 'package:sae_mobile/config/images.dart';
import 'package:sae_mobile/config/theme.dart';

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  bool _viewPassword = false;
  bool _viewPasswordConfirm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickMenuColors.backgroundColorConnexion,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: PickMenuImages.banniere,
            width: 380,
            height: 75,
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 46),
            child: Column(
              spacing: 40,
              children: [
                Text("Inscrivez-vous",
                    style: Theme.of(context).textTheme.headlineMedium),
                TextField(
                  decoration: InputDecoration(hintText: "Nom"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Prénom"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Mot de passe",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _viewPassword = !_viewPassword;
                          });
                        },
                        icon: Icon(_viewPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder!
                            .borderSide
                            .color,
                      )),
                  obscureText: !_viewPassword,
                ),
                Column(
                  spacing: 13,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Confirmation mot de passe",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _viewPasswordConfirm = !_viewPasswordConfirm;
                              });
                            },
                            icon: Icon(_viewPasswordConfirm
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder!
                                .borderSide
                                .color,
                          )),
                      obscureText: !_viewPasswordConfirm,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Déjà un compte ? ",
                        style: PickMenuTheme.spanTextStyle(),
                      ),
                      TextSpan(
                          text: "Connectez-vous",
                          style: PickMenuTheme.spanLinkTextStyle(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("tap");
                            })
                    ]))
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Inscription"),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
