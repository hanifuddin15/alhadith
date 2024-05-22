import 'package:al_hadith/modules/hadith/screen/hadith_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      designSize: const Size(430, 700),
      minTextAdapt: true,
      splitScreenMode: true,
     
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
       
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child:  HadithPage(),
    );
  }
}