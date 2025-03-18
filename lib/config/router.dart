import 'package:go_router/go_router.dart';
import 'package:sae_mobile/src/screens/avis_screen.dart';
import 'package:sae_mobile/src/screens/connexion_screen.dart';
import 'package:sae_mobile/src/screens/detail_screen.dart';
import 'package:sae_mobile/src/screens/home_screen.dart';
import 'package:sae_mobile/src/screens/inscription_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => ConnexionScreen(),
  ),
  GoRoute(
    path: '/inscription',
    builder: (context, state) => InscriptionScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomeScreen(),
  ),
  GoRoute(
    path: '/detail/:id',
    builder: (context, state) {
      final restaurantId = state.pathParameters['id'];
      return DetailScreen(id: restaurantId!);
    },
    routes: [
      GoRoute(
        path: 'avis',
        builder: (context, state) {
          final restaurantId = state.pathParameters['id'];
          return AvisScreen(id: restaurantId!);
        },
      ),
    ],
  ),
]);
