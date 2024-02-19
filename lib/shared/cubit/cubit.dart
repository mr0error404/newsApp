// ignore_for_file: avoid_print, prefer_is_empty, unnecessary_string_interpolations

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/business/busniesScreen.dart';
import 'package:newsapp/modules/science/ScienceScreen.dart';
import 'package:newsapp/modules/settings/settingsScreen.dart';
import 'package:newsapp/modules/sports/sportsScreen.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dioHelper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: "Settings",
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 1) {
    //   getSports();
    // }
    // if (index == 2) {
    //   getScience();
    // }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "us",
          "category": "business",
          "apiKey": "c2e50c4aae664823a2ea97537b191700",
        },
      ).then((value) {
        print("helloNewsDone");
        business = value.data["articles"];
        print(business[5]["title"]);
        emit(NewsGetBusinessSuccessState());

        // print(value.data["articles"][0]["title"].toString());
      }).catchError(
        (error) {
          emit(
            NewsGetBusinessErrorState(
              error.toString(),
            ),
          );
          print(
            "helloNewsError",
          );
          print(
            error.toString(),
          );
        },
      );
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "sports",
          "apiKey": "c2e50c4aae664823a2ea97537b191700",
        },
      ).then((value) {
        print("helloNewsDone");
        sports = value.data["articles"];
        print(sports[5]["title"]);
        emit(NewsGetSportsSuccessState());
      }).catchError(
        (error) {
          emit(
            NewsGetSportsErrorState(
              error.toString(),
            ),
          );
          print(
            "helloNewsError",
          );
          print(
            error.toString(),
          );
        },
      );
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "fr",
          "category": "science",
          "apiKey": "c2e50c4aae664823a2ea97537b191700",
        },
        //https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=c2e50c4aae664823a2ea97537b191700
      ).then((value) {
        print("helloNewsDone ------> science");
        science = value.data["articles"];
        print(science[5]["title"]);
        emit(NewsGetScienceSuccessState());
      }).catchError(
        (error) {
          emit(
            NewsGetScienceErrorState(
              error.toString(),
            ),
          );
          print(
            "helloNewsError  ------>  science",
          );
          print(
            error.toString(),
          );
        },
      );
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    // if (fromShared != null)
    //   isDark = fromShared;
    // else
    //   isDark = !isDark;
    CacheHelper.putData(
      key: "isDark",
      value: isDark,
    ).then((value) {
      emit(AppModeChange());
    });
  }

  // ThemeMode appMode = ThemeMode.dark;
  List<dynamic> search = [];

  void getSearch(String value) {
    search = [];
    emit(NewsGetScienceLoadingState());

    DioHelper.getData(
      url: "v2/everything",
      query: {
        "q": "$value",
        "apiKey": "c2e50c4aae664823a2ea97537b191700",
      },
      //https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=c2e50c4aae664823a2ea97537b191700
    ).then((value) {
      print("helloNewsDone ------> search");
      search = value.data["articles"];
      print(search[5]["title"]);
      emit(NewsGetSearchLoadingState());
    }).catchError(
      (error) {
        emit(
          NewsGetSearchErrorState(
            error.toString(),
          ),
        );
        print(
          "helloNewsError  ------>  science",
        );
        print(
          error.toString(),
        );
      },
    );
    emit(NewsGetSearchSuccessState());
  }
}
