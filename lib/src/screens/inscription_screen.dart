import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sae_mobile/config/colors.dart';
import 'package:sae_mobile/config/images.dart';
import 'package:sae_mobile/config/router.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  bool _viewPassword = false;
  bool _viewPasswordConfirm = false;
  bool _isSubmitting = false;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _nomError;
  String? _prenomError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  void _validateForm() async {
    setState(() {
      _isSubmitting = true;
    });

    setState(() {
      _nomError = null;
      _prenomError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    bool isValid = true;

    if (_nomController.text.trim().isEmpty) {
      setState(() {
        _nomError = 'Veuillez entrer votre nom';
      });
      isValid = false;
    }

    if (_prenomController.text.trim().isEmpty) {
      setState(() {
        _prenomError = 'Veuillez entrer votre prénom';
      });
      isValid = false;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      setState(() {
        _emailError = 'Adresse email invalide';
      });
      isValid = false;
    }

    if (_passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Le mot de passe doit contenir au moins 6 caractères';
      });
      isValid = false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = 'Les mots de passe ne correspondent pas';
      });
      isValid = false;
    }

    if (isValid) {
      DatabaseProvider.signUp(
          nom: _nomController.text,
          prenom: _prenomController.text,
          email: _emailController.text,
          password: _passwordController.text);
      router.go("/");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inscription réussie!')),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 46),
                child: Column(
                  children: [
                    Text("Inscrivez-vous",
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        hintText: "Nom",
                        errorText: _nomError,
                      ),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.familyName],
                      onChanged: (value) {
                        if (_nomError != null) {
                          setState(() {
                            _nomError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                        hintText: "Prénom",
                        errorText: _prenomError,
                      ),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.givenName],
                      onChanged: (value) {
                        if (_prenomError != null) {
                          setState(() {
                            _prenomError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorText: _emailError,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      onChanged: (value) {
                        if (_emailError != null) {
                          setState(() {
                            _emailError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        errorText: _passwordError,
                        suffixIcon: ExcludeFocus(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _viewPassword = !_viewPassword;
                              });
                            },
                            icon: Icon(_viewPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder!
                                .borderSide
                                .color,
                          ),
                        ),
                      ),
                      obscureText: !_viewPassword,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.newPassword],
                      onChanged: (value) {
                        if (_passwordError != null) {
                          setState(() {
                            _passwordError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        TextField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: "Confirmation mot de passe",
                            errorText: _confirmPasswordError,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _viewPasswordConfirm = !_viewPasswordConfirm;
                                });
                              },
                              icon: Icon(_viewPasswordConfirm
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .enabledBorder!
                                  .borderSide
                                  .color,
                            ),
                          ),
                          obscureText: !_viewPasswordConfirm,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.newPassword],
                          onSubmitted: _isSubmitting
                              ? null
                              : (value) {
                                  try {
                                    TextInput.finishAutofillContext(
                                        shouldSave: true);
                                  } catch (e) {
                                    print("Erreur autofill: $e");
                                  }
                                  _validateForm();
                                },
                          onChanged: (value) {
                            if (_confirmPasswordError != null) {
                              setState(() {
                                _confirmPasswordError = null;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 13),
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
                                    router.go("/");
                                  })
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
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
                              _validateForm();
                            },
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text("Inscription"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
