import 'package:flutter/material.dart';
import 'package:sae_mobile/config/colors.dart';

class PickMenuTheme {
  static TextStyle inputHintTextStyle() {
    return const TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        letterSpacing: 0.5,
        fontFamily: 'LXGWWenKaiMonoTC',
        color: PickMenuColors.inputHint);
  }

  static TextStyle inputTextStyle() {
    return const TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        letterSpacing: 0.5,
        fontFamily: 'LXGWWenKaiMonoTC',
        color: PickMenuColors.inputText);
  }

  static TextStyle inputErrorTextStyle() {
    return const TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        letterSpacing: 0.5,
        fontFamily: 'LXGWWenKaiMonoTC',
        color: PickMenuColors.inputErrorText);
  }

  static TextStyle detailClickableTextStyle() {
    return TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        fontFamily: 'LXGWWenKaiMonoTC',
        decoration: TextDecoration.underline,
        color: PickMenuColors.textColor);
  }

  static TextStyle detailTitleTextStyle() {
    return TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        fontFamily: 'LXGWWenKaiMonoTC',
        decoration: TextDecoration.underline,
        color: PickMenuColors.detailTextColor);
  }

  static TextStyle detailTextStyle() {
    return TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        fontFamily: 'LXGWWenKaiMonoTC',
        color: PickMenuColors.detailTextColor);
  }

  static TextStyle elevatedButtonTextStyle() {
    return TextStyle(
        fontSize: 28.0,
        height: 36.0 / 28.0,
        letterSpacing: 0.0,
        fontFamily: 'LXGWWenKaiMonoTC',
        color: PickMenuColors.buttonTextColor);
  }

  static TextStyle spanTextStyle() {
    return TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        letterSpacing: 0.5,
        fontFamily: 'LXGWWenKaiMonoTC',
        color: PickMenuColors.spanTextColor);
  }

  static TextStyle spanLinkTextStyle() {
    return TextStyle(
        fontSize: 16.0,
        height: 24.0 / 16.0,
        letterSpacing: 0.5,
        fontFamily: 'LXGWWenKaiMonoTC',
        decoration: TextDecoration.underline,
        color: PickMenuColors.spanLinkColor);
  }

  static ThemeData defaultTheme() {
    return ThemeData(
      scaffoldBackgroundColor: PickMenuColors.backgroundColor,
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
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: inputHintTextStyle(),
          labelStyle: inputTextStyle(),
          contentPadding: EdgeInsets.only(left: 20, bottom: 9, top: 9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: PickMenuColors.inputBorder,
                width: 2.5,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: PickMenuColors.inputBorder,
                width: 2.5,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: PickMenuColors.inputErrorBorder,
                width: 2.5,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: PickMenuColors.inputErrorBorder,
                width: 2.5,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: PickMenuColors.inputDisabledBorder,
                width: 2.5,
              )),
          errorStyle: inputErrorTextStyle()),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: inputTextStyle().color),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 9, horizontal: 15)),
            backgroundColor: WidgetStatePropertyAll(PickMenuColors.buttonColor),
            foregroundColor:
                WidgetStatePropertyAll(PickMenuColors.buttonTextColor),
            textStyle: WidgetStatePropertyAll(elevatedButtonTextStyle()),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: PickMenuColors.buttonColor)))),
      ),
      checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStatePropertyAll(PickMenuColors.checkboxCheck),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return PickMenuColors.checkboxCheckedFill;
            }
            return PickMenuColors.checkboxUncheckedFill;
          }),
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return BorderSide(
                  color: PickMenuColors.checkboxCheckedBorder, width: 2);
            }
            return BorderSide(
                color: PickMenuColors.checkboxUncheckedBorder, width: 2);
          }),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.5))),
    );
  }
}
