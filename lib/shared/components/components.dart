// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/modules/webView/webViewScreen.dart';

Widget buildArticleItem(article, context ) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(
            url: article['url'],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    // "https://avatars.githubusercontent.com/u/101466323?s=60&v=4",
                    "${article["urlToImage"]}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        "${article["title"]}",
                        style: Theme.of(context).textTheme.bodyText1,
                        // style: TextStyle(
                        //   fontSize: 18.0,
                        //   fontWeight: FontWeight.w600,
                        // ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${article["publishedAt"]}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 35.0,
      ),
      child: Container(
        color: Colors.grey,
        width: double.infinity,
        height: 1.0,
      ),
    );

Widget articleBuilder(list, context , {isSearch = false}) => ConditionalBuilder(
      // condition: state is! NewsGetScienceLoadingState,
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(
          list[index],
          context,
        ),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch ? Container(): Center(
        child: CircularProgressIndicator(),
      ),
    );

Widget defaultFormField({
  required TextEditingController textEditingController,
  required IconData prefix,
  required TextInputType type,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  bool isEnabeld = true,
  Function()? onTap,
  required String? Function(String?)? validation,
  required String lable,
  bool isPassword = false,
  IconData? sufixs,
  Function()? sufixFunction,
  double circular = 30.0,
}) =>
    TextFormField(
      validator: validation,
      controller: textEditingController,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: sufixs != null
            ? IconButton(
                icon: Icon(sufixs),
                onPressed: sufixFunction,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circular),
        ),
      ),
      obscureText: isPassword,
      onTap: onTap,
      enabled: isEnabeld,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
