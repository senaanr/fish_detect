import 'package:fish_detect/features/authentication/screens/fishInfoScreen.dart';
import 'package:fish_detect/features/authentication/screens/homeScreen.dart';
import 'package:fish_detect/features/authentication/screens/imagePickerScreen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomeScreen(),
          ImagePickerScreen(),
          FishInfoScreen(),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Ana Sayfa",
        labels: ["Ana Sayfa", "Kamera", "Balıklar"],
        icons: [Icons.home, Icons.camera_alt, Icons.info_outline],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        tabIconColor: Colors.blue,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue,
        tabIconSelectedColor: Colors.white,
        onTabItemSelected: (int index) {
          setState(() {
            _tabController.index = index;
          });
        },
      ),
    );
  }
}
