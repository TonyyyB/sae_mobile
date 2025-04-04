import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/src/widgets/noteEtoile.dart';



void main() {
  group('SingleRatingIcon Tests', () {
    testWidgets('renders correctly with full rating', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleRatingIcon(
              icon: Icons.star,
              size: 24.0,
              iconColor: Colors.yellow,
              rating: 1.0,
            ),
          ),
        ),
      );

      // Verify the SingleRatingIcon is rendered
      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('renders correctly with partial rating', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleRatingIcon(
              icon: Icons.star,
              size: 24.0,
              iconColor: Colors.yellow,
              rating: 0.5,
            ),
          ),
        ),
      );


      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);

      final ShaderMask shaderMask = tester.widget(find.byType(ShaderMask));


      final Rect rect = Rect.fromLTWH(0, 0, 100, 100);
      final shader = shaderMask.shaderCallback(rect);


      expect(shader, isNotNull);
    });

    testWidgets('respects provided size', (WidgetTester tester) async {
      const double testSize = 40.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleRatingIcon(
              icon: Icons.star,
              size: testSize,
              iconColor: Colors.yellow,
              rating: 1.0,
            ),
          ),
        ),
      );

      final SizedBox sizedBox = tester.widget(find.byType(SizedBox));
      expect(sizedBox.width, equals(testSize));
      expect(sizedBox.height, equals(testSize));
    });
  });

  group('NoteEtoile Tests', () {
    testWidgets('renders 5 full stars when rating is 5.0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteEtoile(rating: 5.0),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);


      expect(find.byIcon(IconData(0xe5f9, fontFamily: 'MaterialIcons')), findsNWidgets(5));


      expect(find.byIcon(IconData(0xe5fa, fontFamily: 'MaterialIcons')), findsNothing);


      expect(find.byType(SingleRatingIcon), findsNothing);
    });

    testWidgets('renders correct mix of stars when rating is 3.5', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteEtoile(rating: 3.5),
          ),
        ),
      );


      expect(find.byType(Row), findsOneWidget);


      expect(find.byIcon(IconData(0xe5f9, fontFamily: 'MaterialIcons')), findsNWidgets(3));

      expect(find.byType(SingleRatingIcon), findsOneWidget);


      expect(find.byIcon(IconData(0xe5fa, fontFamily: 'MaterialIcons')), findsOneWidget);


      final SingleRatingIcon partialStar = tester.widget(find.byType(SingleRatingIcon));
      expect(partialStar.rating, equals(0.5));
    });

    testWidgets('renders all empty stars when rating is 0.0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteEtoile(rating: 0.0),
          ),
        ),
      );


      expect(find.byType(Row), findsOneWidget);


      expect(find.byIcon(IconData(0xe5f9, fontFamily: 'MaterialIcons')), findsNothing);


      expect(find.byType(SingleRatingIcon), findsNothing);


      expect(find.byIcon(IconData(0xe5fa, fontFamily: 'MaterialIcons')), findsNWidgets(5));
    });

    testWidgets('respects provided size parameter', (WidgetTester tester) async {
      const double testSize = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteEtoile(rating: 3.5, size: testSize),
          ),
        ),
      );


      final SingleRatingIcon partialStar = tester.widget(find.byType(SingleRatingIcon));
      expect(partialStar.size, equals(testSize));
    });

    testWidgets('respects provided iconColor parameter', (WidgetTester tester) async {
      const Color testColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteEtoile(rating: 3.5, iconColor: testColor),
          ),
        ),
      );


      final SingleRatingIcon partialStar = tester.widget(find.byType(SingleRatingIcon));
      expect(partialStar.iconColor, equals(testColor));
    });
  });
}