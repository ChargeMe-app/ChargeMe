// import 'package:chargeme/model/station_marker/station_marker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MarkerView extends StatefulWidget {
//   const MarkerView({Key? key, required this.iconType}) : super(key: key);

//   final IconType iconType;

//   @override
//   _MarkerView createState() => _MarkerView();
// }

// class _MarkerView extends State<MarkerView> {
//   final Map<IconType, BitmapDescriptor> _cachedMarkerIcons = {};

//   @override
//   void initState() {
//     super.initState();
//     _setupCachedMarkerIcons();
//   }

//   Future<void> _setupCachedMarkerIcons() async {
//     for (var v in IconType.values) {
//       final icon = await v.getMarkerIcon();
//       if (icon != null) {
//         _cachedMarkerIcons[v] = icon;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
