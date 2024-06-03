import 'package:flutter/material.dart';
import 'dart:ui';
import '../classes/fish.dart';

class FishInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Balık Türleri'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Nesli Tükenmekte Olan Balıklar'),
              Tab(text: 'Zehirli Balıklar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FishListView(fishList: endangeredFishList),
            FishListView(fishList: toxicFishList),
          ],
        ),
      ),
    );
  }
}

class FishListView extends StatefulWidget {
  final List<Fish> fishList;

  FishListView({required this.fishList});

  @override
  _FishListViewState createState() => _FishListViewState();
}

class _FishListViewState extends State<FishListView> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.fishList.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final fish = widget.fishList[index];
              return Stack(
                children: [
                  // Blurred Background Image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(fish.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  // Fish Info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circular Fish Image
                      CircleAvatar(
                        radius: 80, // Artırılan radius değeri
                        backgroundImage: NetworkImage(fish.imageUrl),
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.fishList.length,
                              (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: _currentPage == index ? 12.0 : 8.0,
                            height: _currentPage == index ? 12.0 : 8.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Info Container
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              fish.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              fish.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
