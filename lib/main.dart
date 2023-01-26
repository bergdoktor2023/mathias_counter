import 'package:berg_test/dashboard.dart';
import 'package:berg_test/db.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var savedValues = await dbReadAll();

  runApp(
    MaterialApp(debugShowCheckedModeBanner: false,
      home: Dashboard(
        currentValues: savedValues,
      ),
    ),
  );
}
