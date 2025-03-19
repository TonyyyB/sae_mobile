import 'package:flutter/material.dart';
import 'package:sae_mobile/config/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
