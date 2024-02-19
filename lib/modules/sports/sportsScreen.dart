import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).sports;
    // var businessList = NewsCubit.get(context).business;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        // condition: state is! NewsGetSportsLoadingState,
        condition: list.length > 0,
        builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildArticleItem(
            list[index],
          context,
          ),

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