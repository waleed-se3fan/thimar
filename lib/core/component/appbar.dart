import 'package:flutter/material.dart';
import 'package:salla_thumara/core/component/main_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  CustomAppBar({this.height = kToolbarHeight, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: CustomMainText(text: title, fontSize: 20),
      centerTitle: true,
      leading: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: const Color.fromARGB(68, 76, 134, 19),
              borderRadius: BorderRadius.circular(18)),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded))),
    );
  }
}
