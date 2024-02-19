// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).business;
    // var businessList = NewsCubit.get(context).business;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        // condition: state is! NewsGetBusinessLoadingState,
        condition: list.length > 0,
        builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildArticleItem(
            list[index],
            context,
          ),

          ////
          // itemBuilder: (context, index) {
          //   if (list.isNotEmpty && index < list.length) {
          //     return buildArticleItem(list[index]);
          //   } else {
          //     return Text(
          //       "restdrytfuygiuhoijpok",
          //       style: TextStyle(
          //         color: Colors.blue,
          //       ),
          //     ); // أو يمكنك إرجاع عنصر فارغ أو رسالة لا يوجد بيانات
          //   }
          // },

          ///
          // itemBuilder: (context, index) {
          //   final article = businessList[index];
          //   return buildArticleItem(article);
          // },
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
        ),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
