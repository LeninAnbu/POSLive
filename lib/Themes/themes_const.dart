// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../Constant/colorGenarator.dart';
import '../Constant/colorpalates.dart';

ThemeData merronTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, //Palettes.primary,
    // primarySwatch: generateMaterialColor(Palettes.primary),
    fontFamily:
        'Nunito', //HelveticaNow,SEGOEUIL,ayar,Ordina-WideThin,Celias-Medium*,
    //TruenoRound
    //Quicksand_Bold_Oblique,NovaRegular,Sabon*,OpenSans-Regular
    appBarTheme: AppBarTheme(backgroundColor: Colors.white
        //  foregroundColor: Colors.red,
        ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue, // Palettes.primary
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blue, //Palettes.primary.withOpacity(1)
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'Segoe')))),

    textTheme: TextTheme(
      displaySmall: TextStyle(fontFamily: 'SEGOEUIL'),
      displayLarge: TextStyle(fontFamily: 'SEGOEUIL'),
      displayMedium: TextStyle(fontFamily: 'SEGOEUIL'),
      headlineMedium: TextStyle(fontFamily: 'SEGOEUIL'),
      headlineSmall: TextStyle(fontFamily: 'SEGOEUIL'),
      titleLarge: TextStyle(fontFamily: 'SEGOEUIL'),
      bodyLarge: TextStyle(fontFamily: 'SEGOEUIL', fontSize: 18),
      bodyMedium: TextStyle(fontFamily: 'SEGOEUIL'),
      titleMedium: TextStyle(fontFamily: 'SEGOEUIL'),
      titleSmall: TextStyle(fontFamily: 'SEGOEUIL'),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blue, // Palettes.primary
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blue, // Palettes.primary
        ),
      ),
    ),

    iconTheme: IconThemeData(color: Colors.white),
  );
}

//

ThemeData blueTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary2,
    primarySwatch: generateMaterialColor(Palettes.primary2),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white
        //  foregroundColor: Colors.red,
        ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary2.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'Segoe')))),
    textTheme: TextTheme(
      displaySmall: TextStyle(fontFamily: 'Segoe'),
      displayLarge: TextStyle(fontFamily: 'Segoe'),
      displayMedium: TextStyle(fontFamily: 'Segoe'),
      headlineMedium: TextStyle(fontFamily: 'Segoe'),
      headlineSmall: TextStyle(fontFamily: 'Segoe'),
      titleLarge: TextStyle(fontFamily: 'Segoe'),
      bodyLarge: TextStyle(fontFamily: 'Segoe', fontSize: 18),
      bodyMedium: TextStyle(fontFamily: 'Segoe'),
      titleMedium: TextStyle(fontFamily: 'Segoe'),
      titleSmall: TextStyle(fontFamily: 'Segoe'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary2),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}

//orange

ThemeData orangeTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary3,
    primarySwatch: generateMaterialColor(Palettes.primary3),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white
        //  foregroundColor: Colors.red,
        ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary3),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary3.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'Segoe')))),
    textTheme: TextTheme(
      displaySmall: TextStyle(fontFamily: 'Segoe'),
      displayLarge: TextStyle(fontFamily: 'Segoe'),
      displayMedium: TextStyle(fontFamily: 'Segoe'),
      headlineMedium: TextStyle(fontFamily: 'Segoe'),
      headlineSmall: TextStyle(fontFamily: 'Segoe'),
      titleLarge: TextStyle(fontFamily: 'Segoe'),
      bodyLarge: TextStyle(fontFamily: 'Segoe', fontSize: 18),
      bodyMedium: TextStyle(fontFamily: 'Segoe'),
      titleMedium: TextStyle(fontFamily: 'Segoe'),
      titleSmall: TextStyle(fontFamily: 'Segoe'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary3),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary3),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}

//DARK
ThemeData darkTheme(BuildContext context) {
  return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: generateMaterialColor(Palettes.primary),
      primaryColorDark:
          Palettes.primary, //generateMaterialColor(Palette.primary),
      primaryColor: Palettes.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: Palettes.primary,
        // foregroundColor: Colors.red,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Palettes.primary),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                vertical: 10,
              ) //horizontal: 30
                  ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: MaterialStateProperty.all<Color>(Palettes.primary),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              // overlayColor:  MaterialStateProperty.all<Color>(Colors.black26),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: Colors.white, fontFamily: 'Segoe')))),
      textTheme: TextTheme(
        displaySmall: TextStyle(fontFamily: 'Segoe'),
        displayLarge: TextStyle(fontFamily: 'Segoe'),
        displayMedium: TextStyle(fontFamily: 'Segoe'),
        headlineMedium: TextStyle(fontFamily: 'Segoe'),
        headlineSmall: TextStyle(fontFamily: 'Segoe'),
        titleLarge: TextStyle(fontFamily: 'Segoe'),
        bodyLarge: TextStyle(fontFamily: 'Segoe'),
        bodyMedium: TextStyle(fontFamily: 'Segoe'),
        titleMedium: TextStyle(fontFamily: 'Segoe'),
        titleSmall: TextStyle(fontFamily: 'Segoe'),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Palettes.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Palettes.primary),
        ),
      ),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all<Color>(Colors.grey),
          thumbColor: MaterialStateProperty.all<Color>(Colors.white)),
      primaryIconTheme: IconThemeData(color: Colors.amber),
      iconTheme: IconThemeData(color: Colors.white));
}
