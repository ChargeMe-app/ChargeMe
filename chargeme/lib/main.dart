import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view_model/AddStationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/src/locations.dart' as locations;
import 'package:chargeme/view/map/map.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => AddStationViewModel(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Add station'),
            backgroundColor: ColorPallete.violetBlue,
          ),
          body: AddStationView()), // GMap()),
    );
  }
}
