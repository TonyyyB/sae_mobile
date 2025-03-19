import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sae_mobile/config/colors.dart';
import 'package:sae_mobile/config/images.dart';
import 'package:sae_mobile/config/router.dart';
import 'package:sae_mobile/config/theme.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  bool _viewPassword = false;
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
                Text("Connectez-vous",
                    style: Theme.of(context).textTheme.headlineMedium),
                TextField(
                  decoration: InputDecoration(hintText: "Email"),
                ),
                Column(
                  spacing: 13,
                  children: [
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
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Pas encore de compte ? ",
                        style: PickMenuTheme.spanTextStyle(),
                      ),
                      TextSpan(
                          text: "Inscrivez-vous",
                          style: PickMenuTheme.spanLinkTextStyle(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              router.go("/inscription");
                            })
                    ]))
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Connexion"),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
