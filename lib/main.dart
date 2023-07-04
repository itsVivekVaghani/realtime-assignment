import 'package:assignment/utills/app_text_theme.dart';
import 'package:assignment/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(428, 926),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: const Color(0xff1DA1F2),
              textTheme: GoogleFonts.getTextTheme(
                  "Roboto", const TextTheme()),
              appBarTheme: AppBarTheme(
                backgroundColor: const Color(0xff1DA1F2),
                titleTextStyle: AppTextTheme.appBarTextTheme,
                elevation: 0
              ),
              iconTheme: const IconThemeData(
                color: Color(0xff1DA1F2),
              ),

          ),
          home: const Home(),
        );
      },

    );
  }
}

