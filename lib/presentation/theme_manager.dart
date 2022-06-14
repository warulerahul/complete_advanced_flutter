import 'package:complete_advanced_flutter/presentation/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/values_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';

ThemeData getApplicationThemeDate(){
  return ThemeData(
    // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),
    // ripple color
    splashColor: ColorManager.primaryOpacity70,

    // card view theme
      cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4),

    // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),
    // Button theme
      buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),

  // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white),
          primary: ColorManager.primary,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12)))),

    // Text theme

    // input decoration theme (text form field)
  );
}
