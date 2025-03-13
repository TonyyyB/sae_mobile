import 'package:flutter/material.dart';
import 'package:sae_mobile/src/theme.dart';
import 'package:sae_mobile/src/widgets/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: PickMenuTheme.defaultTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PickMenu"),
      ),
      body: Center(
        child: Column(
          spacing: 40,
          children: [
            Text("Connectez-vous", style: Theme.of(context).textTheme.headlineMedium),
            const TextField(
              decoration: InputDecoration(
                hintText: "Email"
              )
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "Mot de passe"
              ),
              
            ),
            ElevatedButton(
              onPressed: (){},
              child: const Text("Connexion")
              ),
          ],
        ),
      ),
    );
  }
}