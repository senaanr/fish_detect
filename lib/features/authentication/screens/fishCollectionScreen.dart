import 'package:flutter/material.dart';

import 'detailsScreen.dart';

class CollectionScreen extends StatelessWidget {
  final List<Map<String, String>> savedObservations;

  const CollectionScreen({Key? key, required this.savedObservations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaydedilenler'),
      ),
      body: savedObservations.isEmpty
          ? Center(
        child: Text('Henüz kaydedilen balık gözlemi yok.'),
      )
          : ListView.builder(
        itemCount: savedObservations.length,
        itemBuilder: (context, index) {
          final observation = savedObservations[index];
          return ListTile(
            title: Text(observation['fish']!),
            subtitle: Text(observation['location']!),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(observation['imageUrl']!),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(observation: observation),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCollectionDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddCollectionDialog(BuildContext context) {
    String newCollectionName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Koleksiyon Oluştur'),
          content: TextField(
            onChanged: (value) {
              newCollectionName = value;
            },
            decoration: InputDecoration(
              hintText: 'Koleksiyon adını girin',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Oluştur'),
              onPressed: () {
                // Koleksiyon adı ve kaydedilen gözlemlerle bir şeyler yapabilirsiniz
                _createNewCollection(newCollectionName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _createNewCollection(String collectionName) {
    // Yeni koleksiyonu oluşturmak için burada yapılacak işlemler
    // Örneğin: storage.writeNewCollection(collectionName, savedObservations);
    // Bu fonksiyon, yeni koleksiyon adı ve mevcut gözlemlerle bir şeyler yapabilir
    print('Yeni koleksiyon oluşturuldu: $collectionName');
  }
}
