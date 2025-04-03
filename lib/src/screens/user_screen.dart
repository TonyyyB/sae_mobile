import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sae_mobile/config/colors.dart';
import 'package:sae_mobile/config/images.dart';
import 'package:sae_mobile/config/router.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _viewPassword = false;
  bool _viewPasswordConfirm = false;
  bool _isSubmitting = false;
  bool _isLoading = true;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _nomError;
  String? _prenomError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _generalError;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    // Récupérer l'email de l'utilisateur actuel
    final user = DatabaseProvider.getUser();
    if (user != null) {
      _emailController.text = user.email ?? '';

      // Récupérer le nom et prénom
      final userInfo = await DatabaseProvider.getSelfNomPrenom();
      if (userInfo != null) {
        setState(() {
          _nomController.text = userInfo.$1;
          _prenomController.text = userInfo.$2;
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _validateForm() async {
    setState(() {
      _isSubmitting = true;
      _generalError = null;
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

    // Vérification des mots de passe uniquement si l'utilisateur en a saisi un nouveau
    if (_passwordController.text.isNotEmpty) {
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
    }

    if (isValid) {
      // Utilisation de la méthode updateUserInfo de DatabaseProvider
      String? error = await DatabaseProvider.updateUserInfo(
        nom: _nomController.text,
        prenom: _prenomController.text,
        password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
      );

      if (error != null) {
        setState(() {
          _generalError = error;
        });
      } else {
        // Réinitialiser les champs de mot de passe après une mise à jour réussie
        _passwordController.clear();
        _confirmPasswordController.clear();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil mis à jour avec succès !')),
          );
        }
      }
    }

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _signOut() async {
    await DatabaseProvider.signOut();
    router.go("/");
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
      appBar: AppBar(
        title: const Text("Mon profil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: "Déconnexion",
          ),
        ],
      ),
      backgroundColor: PickMenuColors.backgroundColorConnexion,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
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
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 46),
                child: Column(
                  children: [
                    Text("Gérer mon profil",
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 40),
                    if (_generalError != null)
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _generalError!,
                          style: TextStyle(color: Colors.red.shade900),
                        ),
                      ),
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: "Nom",
                        errorText: _nomError,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if (_nomError != null) {
                          setState(() {
                            _nomError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                        labelText: "Prénom",
                        errorText: _prenomError,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if (_prenomError != null) {
                          setState(() {
                            _prenomError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Impossible de modifier l'email",
                      ),
                      enabled: false,
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      "Modifier votre mot de passe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Nouveau mot de passe",
                        hintText: "Laissez vide pour conserver le mot de passe actuel",
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
                      onChanged: (value) {
                        if (_passwordError != null) {
                          setState(() {
                            _passwordError = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: "Confirmer le nouveau mot de passe",
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
                      onSubmitted: _isSubmitting
                          ? null
                          : (value) {
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
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _validateForm,
                      child: _isSubmitting
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        ),
                      )
                          : const Text("Mettre à jour le profil"),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        router.go("/favoris");
                      },
                      icon: const Icon(Icons.favorite),
                      label: const Text("Voir mes favoris"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
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