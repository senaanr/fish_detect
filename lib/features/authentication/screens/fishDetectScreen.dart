import 'package:flutter/material.dart';
import 'dart:io';

class FishDetectScreen extends StatelessWidget {
  final String detectedFishName;
  final String detectedFishInfo;
  final String detectedFishImage;

  const FishDetectScreen({
    Key? key,
    required this.detectedFishName,
    required this.detectedFishInfo,
    required this.detectedFishImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tespit Edilen Balık: " + detectedFishName,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.file(File(detectedFishImage),width: 200,height: 200,),
            SizedBox(height: 16),
            Center(
              child: Text(
                detectedFishName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              detectedFishInfo,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implement the report functionality here
              },
              child: Text("Tespit Edilen Balığı Bildir"),
            ),
          ],
        ),
      ),
    );
  }
}
