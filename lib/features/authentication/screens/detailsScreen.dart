import 'package:flutter/material.dart';

import 'mapScreen.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, String> observation;

  DetailsScreen({required this.observation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(observation['fish']!),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(observation['imageUrl']!, fit: BoxFit.cover),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  '${observation['fish']}',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MapScreen(
                            location: observation['location']!,
                            latitude: double.parse(observation['latitude']!),
                            longitude: double.parse(observation['longitude']!),
                          ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          'Konum: ${observation['location']}',
                          style: TextStyle(fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoContainer('Min Boyut',
                        observation['poisonous'] == 'true' ? '50 cm' : '50 cm'),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: _buildInfoContainer('Max Boyut',
                        observation['endangered'] == 'true' ? '150 cm' : '150 cm'),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              _buildContainer("Zehirli mi?",
                  observation['poisonous'] == 'true' ? 'Evet' : 'Hayır'),
              SizedBox(height: 12.0),
              _buildContainer("Nesli tükenmek üzere mi?",
                  observation['endangered'] == 'true' ? 'Evet' : 'Hayır'),
              SizedBox(height: 12.0),
              _buildContainer("Yaşam Alanları", 'Akdeniz Kıyıları'),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String title, String content) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              content,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(String title, String content) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}