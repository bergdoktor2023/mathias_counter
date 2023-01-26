import 'dart:io';
import 'package:berg_test/db.dart';
import 'package:path_provider/path_provider.dart';

class ExportHandler {
  Future<String?> get _localPath async {
    final dir = await getExternalStorageDirectory();
    if (dir != null) {
      return dir.path;
    }
    return null;
  }

  Future<File?> get _localFile async {
    final path = await _localPath;
    if (path != null) {
      return File('$path/data.csv');
    }
    return null;
  }

  Future<String?> writeCsvToStorage() async {
    Map<String, int> dbValues = await dbReadAll();

    List<List<dynamic>> list = [
      [''],
    ];

    for (var entry in dbValues.entries) {
      list.add([entry.value]);
    }

    final File? file = await _localFile;
    if (file == null) {
      return null;
    }

    String csv = '';
    for (List<dynamic> row in list) {
      csv += '${row.join(',')}\n';
    }

    await file.writeAsString(csv);
    return file.path;
  }
}
