

import 'package:shared_preferences/shared_preferences.dart';

Future<void> dbSet(String groupName, int value) async {
  String dbKey = 'counter_$groupName';


  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt(dbKey, value);
}

Future<int> dbRead(String groupName) async {
  String dbKey = 'counter_$groupName';

  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt(dbKey) ?? 0;

}

Future<Map<String, int>> dbReadAll() async {

  var itnValue = await dbRead('ITN');
  var lmValue = await dbRead('LM');
  var videoValue = await dbRead('Video');
  var fiberValue = await dbRead('Fiber');
  var pdaValue = await dbRead('PDA');
  var spaValue = await dbRead('SPA');
  var nfbValue = await dbRead('NFB');
  var axbValue = await dbRead('AXB');
  var isbValue = await dbRead('ISB');
  var dibValue = await dbRead('DIB');
  var zvkValue = await dbRead('ZVK');
  var artValue = await dbRead('ART');
  var bronchoValue = await dbRead('Broncho');
  var pleuraValue = await dbRead('Pleura');
  var sectioitnValue = await dbRead('Sectio ITN');
  var sectioregValue = await dbRead('Sectio Reg.');
  var pdageburtValue = await dbRead('PDA Geburt');
  var kindValue = await dbRead('Kind');
  var abdomenValue = await dbRead('Abdomen');
  var asa3Value = await dbRead('ASA 3');
  var kopfValue = await dbRead('Kopf');
  var kopfhalsValue = await dbRead('Kopf/Hals');
  var thoraxValue = await dbRead('Thorax');
  var ambulantValue = await dbRead('Ambulant') ;


  // var pdaValue = await dbRead('');
  //...

  return {
    'ITN': itnValue,
    'LM': lmValue,
    'Video': videoValue,
    'Fiber': fiberValue,
    'PDA': pdaValue,
    'SPA': spaValue,
    'NFB': nfbValue,
    'AXB': axbValue,
    'ISB': isbValue,
    'DIB': dibValue,
    'ZVK': zvkValue,
    'ART': artValue,
    'Broncho': bronchoValue,
    'Pleura': pleuraValue,
    'Sectio ITN': sectioitnValue,
    'Sectio Reg.': sectioregValue,
    'PDA Geburt': pdageburtValue,
    'Kind': kindValue,
    'Abdomen': abdomenValue,
    'ASA 3': asa3Value,
    'Kopf': kopfValue,
    'Kopf/Hals': kopfhalsValue,
    'Thorax': thoraxValue,
    'Ambulatn': ambulantValue,
  };
}
