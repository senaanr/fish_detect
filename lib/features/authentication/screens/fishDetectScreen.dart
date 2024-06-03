import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/fish.dart';

class FishDetectScreen extends StatefulWidget {
  FishDetectScreen({Key? key}) : super(key: key);

  @override
  State<FishDetectScreen> createState() => _FishDetectScreenState();
}

class _FishDetectScreenState extends State<FishDetectScreen> {
  late SharedPreferences prefs;

  Future<void> getprefs() async {
    prefs = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    super.initState();
    getprefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(fishObservations[1] as String,),
      ),),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              width: Get.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                     // Get.to(HistoryPage(history: widget.food.history!));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 75,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.history_edu),
                              Container(
                                margin: const EdgeInsets.only(left: 15,right: 15),
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Text("Tarihçesi",style: TextStyle(fontWeight: FontWeight.w800),)
                            ],
                          ),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //Get.to(ContainsPage(contains: widget.food.contents!));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 75,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.fastfood),
                              Container(
                                margin: const EdgeInsets.only(left: 15,right: 15),
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Text("İçindekiler",style: TextStyle(fontWeight: FontWeight.w800),)
                            ],
                          ),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //Get.to(() => HowToPage(video: widget.food.howTo!));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 75,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.question_mark),
                              Container(
                                margin: const EdgeInsets.only(left: 15,right: 15),
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Text("Nasıl Yapılır",style: TextStyle(fontWeight: FontWeight.w800),)
                            ],
                          ),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //Get.to(NutritivePage(nutritive: widget.food.nutritive!));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 75,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.food_bank_rounded),
                              Container(
                                margin: const EdgeInsets.only(left: 15,right: 15),
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Text("Besin Değerleri",style: TextStyle(fontWeight: FontWeight.w800),)
                            ],
                          ),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final List<String>? items = prefs.getStringList(fishObservations[1] as String);
                      //Get.to(CommentPage(widget.food.title!,items));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 75,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star_border),
                              Container(
                                margin: const EdgeInsets.only(left: 15,right: 15),
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Text("Değerlendirme",style: TextStyle(fontWeight: FontWeight.w800),)
                            ],
                          ),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}

final List<Map<String, String>> fishObservations = [
  {
    'location': 'Antalya, Türkiye',
    'fish': 'Akya Balığı',
    'imageUrl': 'https://www.motorboatdergi.com/wp-content/uploads/2021/04/akya-baligi-1170x700.jpg',
    'latitude': '36.8969',
    'longitude': '30.7133',
  },
  {
    'location': 'İzmir, Türkiye',
    'fish': 'Barbun Balığı',
    'imageUrl': 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQ52BxeAhk7CTpCKZVkethB9QsF44HJ6shUHfwfOG26a5umAuYH',
    'latitude': '38.4192',
    'longitude': '27.1287',
  },
  {
    'location': 'Mersin, Türkiye',
    'fish': 'Deniz Alası',
    'imageUrl': 'https://balikdunyasi.com.tr/wp-content/uploads/2021/06/deniz-alasi-butun.jpg',
    'latitude': '28.4192',
    'longitude': '17.1287',
  },
  {
    'location': 'Çanakkale, Türkiye',
    'fish': 'Kılıç Balığı',
    'imageUrl': 'https://www.esk.gov.tr/upload/Node/10988/pics/Kilic.350px.jpg',
    'latitude': '38.4192',
    'longitude': '27.1287',
  },
  {
    'location': 'Bodrum, Türkiye',
    'fish': 'Mercan Balığı',
    'imageUrl': 'https://akvatek.com.tr/wp-content/uploads/urun-antenli-mercan.jpg',
    'latitude': '38.4192',
    'longitude': '27.1287',
  },
];
