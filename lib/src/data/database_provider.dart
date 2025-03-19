import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseProvider {
  Session? session;
  User? user;
  DatabaseProvider._internal();

  static Future<DatabaseProvider> create() async {
    await Supabase.initialize(
        url: dotenv.env['DB_URL']!, anonKey: dotenv.env['DB_KEY']!);
    return DatabaseProvider._internal();
  }

  void signIn(String email, String password) async {
    final AuthResponse res = await Supabase.instance.client.auth
        .signInWithPassword(
            email: 'lobjois-m@hotmail.com', password: 'motdepasse');
    session = res.session;
    user = res.user;
  }

  void signUp(
      String nom, String prenom, String email, String motdepasse) async {}
}
