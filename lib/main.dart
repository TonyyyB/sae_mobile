import 'package:flutter/material.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sae_mobile/models/restaurant.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env['DB_URL']!, anonKey: dotenv.env['DB_KEY']!);
  await DatabaseProvider.signIn(
      email: "tony.beaujouan2@gmail.com", password: "motdepasse");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: PickMenuTheme.defaultTheme(),
    );
  }
}
