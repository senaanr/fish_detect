import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget child;

  CustomAppBar({required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final EdgeInsets padding = mediaQuery.padding;

    return Container(
      padding: EdgeInsets.only(top: padding.top),
      height: height + padding.top,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: child,
    );
  }

  @override
  Size get preferredSize {
    final MediaQueryData mediaQuery = MediaQueryData.fromView(WidgetsBinding.instance!.window);
    final EdgeInsets padding = mediaQuery.padding;

    return Size.fromHeight(height + padding.top);
  }
}
