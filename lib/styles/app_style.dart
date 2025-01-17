import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/cache/palette.dart';

class Styles {

  static ThemeData themeData({bool? isDark}) {
    return ThemeData(
        fontFamily: 'Satoshi',
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        unselectedWidgetColor: isDark == true? Colors.white: Colors.black,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: const Color(0xFFEDEDED)
        ).copyWith(
          background: isDark == true? Colors.black: Colors.white,
        ),
        indicatorColor: const Color(0xffCBDCF8),

        splashColor: primaryColor.withOpacity(0.2),
        highlightColor: primaryColor.withOpacity(0.2),
        hoverColor: const Color(0xff4285F4),

        focusColor: const Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        iconTheme: IconThemeData(
          color: isDark == true? Colors.white: textColor
        ),
        dividerColor: Colors.grey.shade100,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: isDark == true? Colors.white : textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: TextStyle(
            color: isDark == true? Colors.white : textColor.withOpacity(0.67),
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
          bodyLarge: TextStyle(
            color: isDark == true? Colors.white : textColor,
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isDark == true? Colors.white : textColor
          ),
        ),
        cardColor: isDark == true? Colors.black: Colors.white,
        canvasColor: Colors.grey[50],
        brightness: Brightness.light,
        appBarTheme:  AppBarTheme(
          elevation: 0.0,
          systemOverlayStyle: isDark == true? SystemUiOverlayStyle.light: SystemUiOverlayStyle.dark,
          color: Colors.transparent,
          foregroundColor: textColor,
          iconTheme: IconThemeData(color: isDark == true? Colors.white : textColor),
          titleTextStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: isDark == true? Colors.white : textColor,
          ),
        ),
        scaffoldBackgroundColor: isDark == true?
        const Color(0xFF232323):
        const Color(0xFFF7F7F7),
        shadowColor: Colors.grey,
    );

  }
}