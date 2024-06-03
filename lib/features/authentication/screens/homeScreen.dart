import 'package:flutter/material.dart';
import '../../../utils/storage.dart';
import 'detailsScreen.dart';
import 'fishCollectionScreen.dart';
import '../../components/customAppBar/customAppBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredObservations = fishObservations;
  List<Map<String, String>> savedObservations = [];
  final Storage storage = Storage();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterObservations);
    _loadSavedObservations();
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterObservations);
    _searchController.dispose();
    super.dispose();
  }

  void _filterObservations() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredObservations = fishObservations;
      } else {
        filteredObservations = fishObservations.where((observation) {
          final fish = observation['fish']!.toLowerCase();
          final location = observation['location']!.toLowerCase();
          return fish.contains(query) || location.contains(query);
        }).toList();
      }
    });
  }

  Future<void> _loadSavedObservations() async {
    final observations = await storage.readObservations();
    setState(() {
      savedObservations = observations;
    });
  }

  void _saveObservation(Map<String, String> observation) {
    setState(() {
      if (!savedObservations.contains(observation)) {
        savedObservations.add(observation);
        storage.writeObservations(savedObservations);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Observation kaydedildi!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bu observation zaten kaydedildi!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold key here
      appBar: CustomAppBar(
        height: kToolbarHeight,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer(); // Open drawer using key
              },
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Balık veya konum ara...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(Icons.search, color: Colors.white),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[500],
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Arşiv'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CollectionScreen(savedObservations: savedObservations),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark_outlined),
              title: Text('Kaydedilenler'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CollectionScreen(savedObservations: savedObservations),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support),
              title: Text('İletişime Geç'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CollectionScreen(savedObservations: savedObservations),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: filteredObservations.length,
        itemBuilder: (context, index) {
          final observation = filteredObservations[index];
          bool isSaved = savedObservations.contains(observation);

          return Card(
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Image.network(observation['imageUrl']!, fit: BoxFit.cover),
                ),
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.blue),
                  title: Text(observation['location']!),
                  subtitle: Text('Görülen balık: ${observation['fish']}'),
                  trailing: IconButton(
                    icon: Icon(
                      isSaved ? Icons.bookmark_added_outlined : Icons.bookmark_border,
                      color: isSaved ? Colors.blue : null,
                    ),
                    onPressed: () {
                      _saveObservation(observation);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(observation: observation),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
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
