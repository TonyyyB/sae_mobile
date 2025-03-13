import 'package:flutter/material.dart';
import 'package:sae_mobile/src/utils/colors.dart';

class PickMenuTheme {
  static ThemeData defaultTheme() {
    return ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 57.0,
              height: 64.0 / 57.0,
              letterSpacing: -0.25,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          displayMedium: TextStyle(
              fontSize: 45.0,
              height: 52.0 / 45.0,
              letterSpacing: 0.0,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          displaySmall: TextStyle(
              fontSize: 36.0,
              height: 44.0 / 36.0,
              letterSpacing: 0.0,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          headlineLarge: TextStyle(
              fontSize: 32.0,
              height: 40.0 / 32.0,
              letterSpacing: 0.0,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          headlineMedium: TextStyle(
              fontSize: 28.0,
              height: 36.0 / 28.0,
              letterSpacing: 0.0,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          headlineSmall: TextStyle(
              fontSize: 24.0,
              height: 32.0 / 24.0,
              letterSpacing: 0.0,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          titleLarge: TextStyle(
              fontSize: 22.0,
              height: 28.0 / 22.0,
              letterSpacing: 0.0,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          titleMedium: TextStyle(
              fontSize: 16.0,
              height: 24.0 / 16.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.15,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          titleSmall: TextStyle(
              fontSize: 14.0,
              height: 20.0 / 14.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          bodyLarge: TextStyle(
              fontSize: 16.0,
              height: 24.0 / 16.0,
              letterSpacing: 0.5,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          bodyMedium: TextStyle(
              fontSize: 14.0,
              height: 20.0 / 14.0,
              letterSpacing: 0.25,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          bodySmall: TextStyle(
              fontSize: 12.0,
              height: 16.0 / 12.0,
              letterSpacing: 0.4,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          labelLarge: TextStyle(
              fontSize: 14.0,
              height: 20.0 / 14.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          labelMedium: TextStyle(
              fontSize: 12.0,
              height: 16.0 / 12.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
          labelSmall: const TextStyle(
              fontSize: 11.0,
              height: 16.0 / 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              fontFamily: 'LXGWWenKaiMonoTC',
              color: PickMenuColors.textColor),
        ),

        );
  }
}
