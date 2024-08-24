import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/saved_observations.json');
  }

  Future<List<Map<String, String>>> readObservations() async {
    try {
      final file = await _localFile;

      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<Map<String, String>>.from(json.decode(contents));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<File> writeObservations(List<Map<String, String>> observations) async {
    final file = await _localFile;
    return file.writeAsString(json.encode(observations));
  }
}
