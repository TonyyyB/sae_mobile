import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/src/data/database_provider.dart';
import 'package:sae_mobile/src/screens/avis_screen.dart';
import 'package:sae_mobile/src/screens/connexion_screen.dart';
import 'package:sae_mobile/src/screens/detail_screen.dart';
import 'package:sae_mobile/src/screens/favoris_cuisine_screen.dart';
import 'package:sae_mobile/src/screens/favoris_restaurant_screen.dart';
import 'package:sae_mobile/src/screens/home_screen.dart';
import 'package:sae_mobile/src/screens/inscription_screen.dart';
import 'package:sae_mobile/src/screens/user_screen.dart';
import 'package:sae_mobile/src/screens/search_screen.dart';
import 'package:sae_mobile/src/widgets/scaffold.dart';

final GoRouter router = GoRouter(
    redirect: (context, state) {
      final loggedIn = DatabaseProvider.isAuthenticated();
      final goingToLogin = state.uri.toString() == '/';
      final goingToSignUp = state.uri.toString() == '/inscription';

      if (!loggedIn && !goingToLogin && !goingToSignUp) {
        return '/';
      }
      if (loggedIn && (goingToLogin || goingToSignUp)) {
        return '/home';
      }
      if (state.uri.toString() == '/favoris') {
        return '/';
      }
      return null; // Pas de redirection
    },
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => ConnexionScreen(),
          routes: [
            GoRoute(
              path: 'inscription',
              builder: (context, state) => InscriptionScreen(),
            ),
          ]),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: "/search",
        builder: (context, state) {
          final args = state.extra! as Map<String, dynamic>;
          return SearchScreen(
            cuisines: args['cuisines']!,
            types: args['types']!,
            options: args['options']!,
            search: args['search']!,
          );
        },
      ),
      GoRoute(
          path: '/detail/:id',
          builder: (context, state) {
            final restaurantId = int.parse(state.pathParameters['id']!);
            return DetailsScreen(restaurantId: restaurantId);
          },
          routes: [
            GoRoute(
              path: 'avis',
              builder: (context, state) {
                final restaurantId = int.parse(state.pathParameters['id']!);
                return AvisScreen(id: restaurantId);
              },
            ),
          ]),
      GoRoute(
        path: '/profil',
        builder: (context, state) => const UserScreen(),
      ),
      GoRoute(
          path: '/favoris',
          builder: (context, state) {
            return PickMenuScaffold(child: CircularProgressIndicator());
          },
          routes: [
            GoRoute(
                path: 'restaurants',
                builder: (context, state) {
                  return FavorisRestaurantScreen();
                }),
            GoRoute(
                path: 'cuisines',
                builder: (context, state) {
                  return FavorisCuisineScreen();
                }),
          ]),
    ]);
