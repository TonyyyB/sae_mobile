import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;

  final SupabaseClient supabase = Supabase.instance.client;

  DatabaseProvider._internal();

  // 🔹 Méthode pour se connecter
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      final response = await supabase.auth
          .signInWithPassword(email: email, password: password);
      if (response.user != null) {
        return null; // Connexion réussie, pas d'erreur
      }
      return "Erreur inconnue lors de la connexion";
    } catch (e) {
      return e.toString(); // Retourne l'erreur en cas d'échec
    }
  }

  // 🔹 Méthode pour s'inscrire
  Future<String?> signUp(
      {required String nom,
      required String prenom,
      required String email,
      required String password}) async {
    try {
      final response =
          await supabase.auth.signUp(email: email, password: password);
      if (response.user != null) {
        await supabase.from("utilisateur").insert({
          "uuid": response.user?.id,
          "nom_utilisateur": nom,
          "prenom_utilisateur": prenom
        });
        return null;
      }
      return "Erreur inconnue lors de l'inscription";
    } catch (e) {
      return e.toString();
    }
  }

  Future<(String?, String?)> getNomPrenom() async {
    final response = await supabase
        .from('utilisateur')
        .select()
        .eq('uuid', supabase.auth.currentUser!.id)
        .single();
    return (
      response['nom_utilisateur'] as String,
      response['prenom_utilisateur'] as String
    );
  }

  // 🔹 Vérifie si l'utilisateur est connecté
  bool isAuthenticated() => supabase.auth.currentSession != null;

  // 🔹 Déconnexion
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
