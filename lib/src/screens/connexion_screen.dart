import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sae_mobile/config/colors.dart';
import 'package:sae_mobile/config/images.dart';
import 'package:sae_mobile/config/router.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  bool _viewPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_clearEmailError);
    _passwordController.addListener(_clearPasswordError);
  }

  @override
  void dispose() {
    _emailController.removeListener(_clearEmailError);
    _passwordController.removeListener(_clearPasswordError);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearEmailError() {
    if (_emailError != null) {
      setState(() {
        _emailError = null;
      });
    }
  }

  void _clearPasswordError() {
    if (_passwordError != null) {
      setState(() {
        _passwordError = null;
      });
    }
  }

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegExp.hasMatch(email);
  }

  void _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!_isValidEmail(email)) {
      setState(() {
        _emailError = "Format d'email invalide";
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = "Le mot de passe est requis";
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final success =
          await DatabaseProvider.signIn(email: email, password: password);

      setState(() {
        _isSubmitting = false;
      });

      if (success == null) {
        router.go('/home');
      } else {
        setState(() {
          _emailError = "Email ou mot de passe incorrect";
          _passwordError = "Email ou mot de passe incorrect";
        });
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Une erreur est survenue : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickMenuColors.backgroundColorConnexion,
      body: Center(
        child: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Connectez-vous",
                        style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(height: 40),
                    AutofillGroup(
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(),
                              errorText: _emailError,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            enableSuggestions: false,
                          ),
                          SizedBox(height: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _passwordController,
                                textInputAction: TextInputAction.go,
                                onSubmitted: _isSubmitting
                                    ? null
                                    : (value) {
                                        try {
                                          TextInput.finishAutofillContext(
                                              shouldSave: true);
                                        } catch (e) {
                                          print("Erreur autofill: $e");
                                        }
                                        _signIn();
                                      },
                                decoration: InputDecoration(
                                  hintText: "Mot de passe",
                                  border: OutlineInputBorder(),
                                  errorText: _passwordError,
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
                                  ),
                                ),
                                obscureText: !_viewPassword,
                                autofillHints: const [AutofillHints.password],
                                enableSuggestions: false,
                              ),
                              SizedBox(height: 13),
                              RichText(
                                text: TextSpan(
                                  children: [
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
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _isSubmitting
                                ? null
                                : () {
                                    try {
                                      TextInput.finishAutofillContext(
                                          shouldSave: true);
                                    } catch (e) {
                                      print("Erreur autofill: $e");
                                    }
                                    _signIn();
                                  },
                            child: _isSubmitting
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Text("Connexion"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
