import 'dart:async';

import 'package:berg_test/db.dart';
import 'package:berg_test/export_handler.dart';
import 'package:berg_test/list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';


const int elementCount = 39;


class Dashboard extends StatefulWidget {

  final Map<String, int> currentValues;
  const Dashboard({
    super.key,
    required this.currentValues,
  });

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  bool showLoadingWidget = false;
  TextEditingController numberInputTextEditController = TextEditingController();

  int? itnValue;
  int? lmValue;
  int? videoValue;
  int? fiberValue;
  int? pdaValue;
  int? spaValue;
  int? nfbValue;
  int? axbValue;
  int? isbValue;
  int? dibValue;
  int? caudValue;
  int? pwbValue;
  int? zvkValue;
  int? artValue;
  int? bronchoValue;
  int? pleuraValue;
  int? sectioitnValue;
  int? sectioregValue;
  int? pdageburtValue;
  int? kindValue;
  int? abdomenValue;
  int? asa3Value;
  int? kopfValue;
  int? kopfhalsValue;
  int? thoraxValue;
  int? ambulantValue;
  int? gesamtValues;
  double? gesamt1800Values;
  int? gesamtRegValue;
  int? gesamtGynValue;
  int? sectioValue;



  TextEditingController _urController = TextEditingController();
  TextEditingController _vornameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dashboardnummerController = TextEditingController();






  //...

  @override
  void initState() {
    initValues(widget.currentValues);



    super.initState();
    _loadSavedData();

    super.initState();
  }
  void initValues(Map<String, int> values) {
    setState(() {
      itnValue = values['ITN'];
      lmValue = values['LM'];
      videoValue = values['Video'];
      fiberValue = values['Fiber'];
      pdaValue = values['PDA'];
      spaValue = values['SPA'];
      nfbValue = values['NFB'];
      axbValue = values['AXB'];
      isbValue = values['ISB'];
      dibValue = values['DIB'];
      caudValue = values['Caud'];
      pwbValue = values['PWB'];
      gesamtRegValue = values['PWB']!+
          values['Caud']!+
          values['DIB']!+
          values['ISB']!+
          values['AXB']!+
          values['NFB']!;

      zvkValue = values['ZVK'];
      artValue = values['ART'];
      bronchoValue = values['Broncho'];
      pleuraValue = values['Pleura'];
      sectioitnValue = values['Sectio ITN'];
      sectioregValue = values['Sectio Reg'];
      pdageburtValue = values['PDA Geburt'];
      sectioValue = values['Sectio Reg']!+values['Sectio ITN']!;
      gesamtGynValue = values['PDA Geburt']!+values['Sectio Reg']!+values['Sectio ITN']!;
      kindValue = values['Kind'];
      abdomenValue = values['Abdomen'];
      asa3Value = values['ASA 3'];
      kopfValue = values['Kopf'];
      kopfhalsValue = values['Kopf/Hals'];
      thoraxValue = values['Thorax'];
      ambulantValue = values['Ambulant'];
      gesamt1800Values =  values['Gesamt']! / 1800;
      gesamtValues = values["ITN"]! +
          values["LM"]!+
          values['PDA Geburt']!+
          values['Pleura']!+
          values['Broncho']!+
          values['PWB']!+
          values['Caud']!+
          values['DIB']!+
          values['ISB']!+
          values['AXB']!+
          values['NFB']!+
          values['SPA']!+
          values['PDA']!+
          values['Fiber']!+
          values['Video']!+
          values['Sectio Reg']!+
          values['Sectio ITN']!



      ;
    });
  }

  Future<void> showFileWriteErrorDialog() async {

    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('File export'),
          content: const Text(
            'Fehler beim export',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  Future<void> _showNumberInputDialog(
      String groupName,
      int currentNumber,
      ) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Aktueller Wert $currentNumber'),
          content: TextField(
            controller: numberInputTextEditController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Neuer Wert',
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                numberInputTextEditController.text = '';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () async {
                int? newValue =
                int.tryParse(numberInputTextEditController.text);
                if (newValue != null) {
                  dbSet(groupName, newValue);
                }
                var newDbValues = await dbReadAll();
                initValues(newDbValues);
                numberInputTextEditController.text = '';
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }





  Future<void> showSendMailDialog(void Function(bool) dialogSelection) async {

    SharedPreferences prefs = await
    SharedPreferences.getInstance();
    String? ur = prefs.getString("ur");
    final Uri _url = Uri.parse("$ur");
    final Uri _urlLernziel = Uri.parse("https://drive.google.com/drive/folders/1RFLifARLch0sIaFIHGUzw_tMmSy-oWj6?usp=share_link");


    Future<void> _launchUrl() async {
      if (!await launchUrl(_url));
      {
        throw Exception('Could not launch $_url');
      }
    }
    Future<void> _launchUrlLernziel() async {
      if (!await launchUrl(_urlLernziel));
      {
        throw Exception('Could not launch $_urlLernziel');
      }
    }
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Was möchstest Du tun?'),
          actions: <Widget>[

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Zahlen übermitteln'),
              onPressed: () {
                Navigator.of(context).pop();
                dialogSelection.call(true);
              },
            ),

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('zu meinem Dashboard'),
              onPressed: _launchUrl
            ),
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('zum Lernzielkatalog'),
                onPressed: _launchUrlLernziel

            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('zurück'),
              onPressed: () {
                Navigator.of(context).pop();
                dialogSelection.call(false);
              },
            ),


          ],
        );
      },
    );



  }
  Future<void> sendMail(String attachmentPath) async {


      SharedPreferences prefs = await
          SharedPreferences.getInstance();
      String? dashboardnummer = prefs.getString("dashboardnummer");
      String? vorname = prefs.getString("vorname");
      String? name = prefs.getString("name");

    final Email email = Email(
      body: "Zahlen von $vorname $name",
      subject: "Dashboardnummer: $dashboardnummer",
      recipients: ['sbergao@gmail.com'],
      attachmentPaths: [attachmentPath],
      isHTML: false,

    );


    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Vielen Dank, Dein Dashboard wird bearbeitet';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),


    );

  }

  void _showForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _dashboardnummerController,
                  decoration: InputDecoration(labelText: "Dashboardnummer"),
                ),
                TextFormField(
                  controller: _vornameController,
                  decoration: InputDecoration(labelText: "Vorname"),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Nachname"),
                ),
                TextFormField(
                  controller: _urController,
                  decoration: InputDecoration(labelText: "Dashboard-Adresse"),
                ),
                ElevatedButton(
                  child: Text("Speichern"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _loadSavedData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _urController.text = prefs.getString("ur") ?? "";
    _nameController.text = prefs.getString("name") ?? "";
    _vornameController.text = prefs.getString("vorname") ?? "";
    _dashboardnummerController.text = prefs.getString("dashboardnummer") ?? "";
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,

        centerTitle: true,
        title: const Text('Dashboard Anästhesie',),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.perm_identity),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("vorname", _vornameController.text);

              prefs.setString("name", _nameController.text);

              prefs.setString("ur", _urController.text);

              prefs.setString("dashboardnummer", _dashboardnummerController.text);
              _showForm();
            },
          ),

          IconButton(
            onPressed: () async {
              Completer<bool> completer = Completer<bool>();
              await showSendMailDialog((sendMail) {
                completer.complete(sendMail);
              });

              var proceedWithMail = await completer.future;

              if (!proceedWithMail) {
                return;
              }

              setState(() {
                showLoadingWidget = true;
              });

              await Future.delayed(const Duration(milliseconds: 400));

              var exportHandler = ExportHandler();
              String? filePath = await exportHandler.writeCsvToStorage();

              if (filePath == null) {
                await showFileWriteErrorDialog();
              } else {
                await sendMail(filePath);
              }

              setState(() {
                showLoadingWidget = false;
              });
            },
            icon: const Icon(
              Icons.menu,
            ),
          ),




        ],

      ),





      body: showLoadingWidget
          ? const Center(

              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            )

          : ListView(

              children: [
                const SizedBox(height: 2),
                ListContainer(
                  containerColor: Color.fromRGBO(39, 89, 99, 50),
                  groupText: 'ITN',
                  currentCount: itnValue?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('ITN', newValue);

                    setState(() {
                      itnValue = newValue;

                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },


                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('ITN', newValue);
                    setState(() {
                      itnValue = newValue;



                    });
                  },
                ),


                const SizedBox(height: 1),

                ListContainer(


                  containerColor: Color.fromRGBO(39, 89, 99, 50),
                  groupText: 'LM',

                  currentCount: lmValue?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('LM', newValue);

                    setState(() {
                      lmValue = newValue;

                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('LM', newValue);
                    setState(() {
                      lmValue = newValue;

                    });
                  },
                ),

                const SizedBox(height: 1),

                ListContainer(
                  containerColor:Color.fromRGBO(39, 89, 99, 50),
                  groupText: 'Video',
                  currentCount: videoValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Video', newValue);
                    setState(() {
                      videoValue = newValue;

                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Video', newValue);
                    setState(() {
                      videoValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),

                const SizedBox(height: 1),
                ListContainer(
                  containerColor:  Color.fromRGBO(39, 89, 99, 50),
                  groupText: 'Fiber',
                  currentCount: fiberValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Fiber', newValue);
                    setState(() {
                      fiberValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Fiber', newValue);
                    setState(() {
                      fiberValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },
                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor:  Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'PDA',
                  currentCount: pdaValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('PDA', newValue);
                    setState(() {
                      pdaValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('PDA', newValue);
                    setState(() {
                      pdaValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'SPA',
                  currentCount: spaValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('SPA', newValue);
                    setState(() {
                      spaValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('SPA', newValue);
                    setState(() {
                      spaValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor:Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'NFB',
                  currentCount: nfbValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('NFB', newValue);
                    setState(() {
                      nfbValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('NFB', newValue);
                    setState(() {
                      nfbValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },
                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'AXB',
                  currentCount: axbValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('AXB', newValue);
                    setState(() {
                      axbValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('AXB', newValue);
                    setState(() {
                      axbValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },
                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor:Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'ISB',
                  currentCount: isbValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('ISB', newValue);
                    setState(() {
                      isbValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('ISB', newValue);
                    setState(() {
                      isbValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'DIB',
                  currentCount: dibValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('DIB', newValue);
                    setState(() {
                      dibValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('DIB', newValue);
                    setState(() {
                      dibValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'Caud',
                  currentCount: caudValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Caud', newValue);
                    setState(() {
                      dibValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Caud', newValue);
                    setState(() {
                      caudValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),

                ListContainer(
                  containerColor: Color.fromRGBO(29, 29, 58, 50),
                  groupText: 'PWB',
                  currentCount: pwbValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('PWB', newValue);
                    setState(() {
                      pwbValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('PWB', newValue);
                    setState(() {
                      pwbValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(252,172,100, 10),
                  groupText: 'ZVK',
                  currentCount: zvkValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('ZVK', newValue);
                    setState(() {
                      zvkValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('ZVK', newValue);
                    setState(() {
                      zvkValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(252,172,100, 10),

                  groupText: 'ART',
                  currentCount: artValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('ART', newValue);
                    setState(() {
                      artValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('ART', newValue);
                    setState(() {
                      artValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(252,172,100, 10),

                  groupText: 'Broncho',
                  currentCount: bronchoValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Broncho', newValue);
                    setState(() {
                      bronchoValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Broncho', newValue);
                    setState(() {
                      bronchoValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(252,172,100, 10),

                  groupText: 'Pleura',
                  currentCount: pleuraValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Pleura', newValue);
                    setState(() {
                      pleuraValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Pleura', newValue);
                    setState(() {
                      pleuraValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),

                ListContainer(
                  containerColor: Color.fromRGBO(142,187,167, 50),
                  groupText: 'Sectio ITN',
                  currentCount: sectioitnValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Sectio ITN', newValue);
                    setState(() {
                      sectioitnValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Sectio ITN', newValue);
                    setState(() {
                      sectioitnValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(142,187,167, 50),
                  groupText: 'Sectio Reg',
                  currentCount: sectioregValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Sectio Reg', newValue);
                    setState(() {
                      sectioregValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Sectio Reg', newValue);
                    setState(() {
                      sectioregValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),

                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(142,187,167, 50),
                  groupText: 'PDA Geburt',
                  currentCount: pdageburtValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('PDA Geburt', newValue);
                    setState(() {
                      pdageburtValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('PDA Geburt', newValue);
                    setState(() {
                      pdageburtValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(142,187,167, 50),
                  groupText: 'Kind',
                  currentCount: kindValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Kind', newValue);
                    setState(() {
                      kindValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Kind', newValue);
                    setState(() {
                      kindValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(110, 100, 200, 100),
                  groupText: 'Abdomen',
                  currentCount: abdomenValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Abdomen', newValue);
                    setState(() {
                      abdomenValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Abdomen', newValue);
                    setState(() {
                      abdomenValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),

                ListContainer(
                  containerColor: Color.fromRGBO(110, 100, 200, 100),
                  groupText: 'ASA 3',
                  currentCount: asa3Value ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('ASA 3', newValue);
                    setState(() {
                      asa3Value = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('ASA 3', newValue);
                    setState(() {
                      asa3Value = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },
                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(110, 100, 200, 100),
                  groupText: 'Kopf',
                  currentCount: kopfValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Kopf', newValue);
                    setState(() {
                      kopfValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Kopf', newValue);
                    setState(() {
                      kopfValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(110, 100, 200, 100),
                  groupText: 'Kopf/Hals',
                  currentCount: kopfhalsValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Kopf/Hals', newValue);
                    setState(() {
                      kopfhalsValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Kopf/Hals', newValue);
                    setState(() {
                      kopfhalsValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(110, 100, 200, 100),
                  groupText: 'Thorax',
                  currentCount: thoraxValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Thorax', newValue);
                    setState(() {
                      thoraxValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Thorax', newValue);
                    setState(() {
                      thoraxValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },

                ),
                const SizedBox(height: 1),
                ListContainer(
                  containerColor: Color.fromRGBO(110, 100, 200, 100),
                  groupText: 'Ambulant',
                  currentCount: ambulantValue ?? 0,
                  onDecrementClicked: (oldValue) async {
                    int newValue = oldValue -= 1;
                    await dbSet('Ambulant', newValue);
                    setState(() {
                      ambulantValue = newValue;
                    });
                  },
                  onIncrementClicked: (oldValue) async {
                    int newValue = oldValue += 1;
                    await dbSet('Ambulant', newValue);
                    setState(() {
                      ambulantValue = newValue;
                    });
                  },
                  onEditNumberClicked: (groupSource, currentValue) async {
                    await _showNumberInputDialog(groupSource, currentValue);
                  },







                ),
                const SizedBox(height: 60),
                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 60,
                      child: LinearProgressIndicator(
                        value: gesamtValues!/1800,
                        backgroundColor: Colors.blueGrey.shade900,
                        color: Colors.lightGreen.shade900,

                      ),

                    ),      Align(child: Text("GESAMT   :   ""$gesamtValues " " / 1800",  style: TextStyle(fontSize: 30, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.5, ),

                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: gesamtRegValue!/50,
                        backgroundColor:Color.fromRGBO(29, 29, 58, 100),
                        color: Color.fromRGBO(29, 29, 58, 50),

                      ),

                    ),      Align(child: Text("Regionalanästhesie : ""$gesamtRegValue " " / 50",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: zvkValue!/30,
                        backgroundColor: Color.fromRGBO(252,172,100, 100),
                        color: Color.fromRGBO(252,172,100, 1),

                      ),

                    ),      Align(child: Text("ZVK : ""$zvkValue " " / 30",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),
                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: artValue!/30,
                        backgroundColor: Color.fromRGBO(252,172,100, 100),
                        color: Color.fromRGBO(252,172,100, 1),

                      ),

                    ),      Align(child: Text("ART : ""$artValue " " / 30",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),
                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: bronchoValue!/25,
                        backgroundColor: Color.fromRGBO(252,172,100, 100),
                        color: Color.fromRGBO(252,172,100, 1),

                      ),

                    ),      Align(child: Text("Broncho : ""$bronchoValue " " / 25",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),
                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: pleuraValue!/5,
                        backgroundColor: Color.fromRGBO(252,172,100, 100),
                        color: Color.fromRGBO(252,172,100, 1),
                      ),

                    ),      Align(child: Text("Pleura : ""$pleuraValue " " / 5",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 20),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: gesamtGynValue!/50,
                        backgroundColor: Color.fromRGBO(142,187,167, 100),
                        color:  Color.fromRGBO(142,187,167, 1),

                      ),

                    ),      Align(child: Text("Geburtshilfe : ""$gesamtGynValue " " / 50",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: sectioValue!/25,
                        backgroundColor: Color.fromRGBO(142,187,167, 100),
                        color:  Color.fromRGBO(142,187,167, 1),

                      ),

                    ),      Align(child: Text("Sectio : ""$sectioValue " " / 25",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: kindValue!/50,
                        backgroundColor: Color.fromRGBO(142,187,167, 100),
                        color:  Color.fromRGBO(142,187,167, 1),

                      ),

                    ),      Align(child: Text("Kindernarkosen : ""$kindValue " " / 50",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 20),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: abdomenValue!/300,
                        backgroundColor: Color.fromRGBO(110, 100, 200, 100),
                        color: Color.fromRGBO(110, 100, 200, 20),

                      ),

                    ),      Align(child: Text("Abdomen : ""$abdomenValue " " / 300",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: asa3Value!/100,
                        backgroundColor: Color.fromRGBO(110, 100, 200, 100),
                        color: Color.fromRGBO(110, 100, 200, 20),

                      ),

                    ),      Align(child: Text("ASA 3 : ""$asa3Value " " / 100",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: kopfValue!/25,
                        backgroundColor: Color.fromRGBO(110, 100, 200, 100),
                        color: Color.fromRGBO(110, 100, 200, 20),

                      ),

                    ),      Align(child: Text("Kopf : ""$kopfValue " " / 25",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: kopfhalsValue!/100,
                        backgroundColor: Color.fromRGBO(110, 100, 200, 100),
                        color: Color.fromRGBO(110, 100, 200, 20),
                      ),

                    ),      Align(child: Text("Kopf/Hals : ""$kopfValue " " / 100",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: thoraxValue!/25,
                        backgroundColor: Color.fromRGBO(110, 100, 200, 100),
                        color: Color.fromRGBO(110, 100, 200, 20),

                      ),

                    ),      Align(child: Text("Thorax : ""$thoraxValue " " / 25",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 1.8, ),

                  ],
                ),
                const SizedBox(height: 1),

                Stack(
                  children: <Widget>[
                    SizedBox(

                      height: 45,
                      child: LinearProgressIndicator(
                        value: ambulantValue!/50,
                        backgroundColor: Color.fromRGBO(110, 100, 200, 100),
                        color: Color.fromRGBO(110, 100, 200, 20),
                      ),

                    ),      Align(child: Text("Ambulant : ""$ambulantValue " " / 50",  style: TextStyle(fontSize: 20, color: Colors.white), ), alignment: Alignment.center, heightFactor: 2.5, ),

                  ],
                ),
              ],
            ));
  }
}

