// ignore_for_file: unnecessary_const, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/newsLayout.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/blocObserver.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dioHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: "isDark");
  runApp(MyApp(isDark ?? false));
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key, required this.isDark});
  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..changeAppMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  // color: Colors.green,
                  elevation: 0.0,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.blue.shade400,
                    elevation: 20.0),
                // bottoAppBarTheme: BottomAppBarTheme(
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.blue.shade400,
                ),
                textTheme: const TextTheme(
                  bodyText1: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                // ),
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFF505050),
                primarySwatch: Colors.blue,
                // scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: const Color(0xFF505050),
                    statusBarBrightness: Brightness.light,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  backgroundColor: const Color(0xFF505050),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  // color: Colors.green,
                  elevation: 0.0,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xFF505050),
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                ),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              home: const Directionality(
                textDirection: TextDirection.ltr,
                child: NewsApp(),
              ),
            );
          }),
    );
  }
}
