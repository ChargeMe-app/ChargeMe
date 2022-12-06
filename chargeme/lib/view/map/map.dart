import 'package:chargeme/view/map/loading_view.dart';
import 'package:chargeme/view/map/search_bar_view.dart';
import 'package:chargeme/view/map/search_results_view.dart';
import 'package:chargeme/view_model/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:provider/provider.dart';

class GMap extends StatefulWidget {
  const GMap({Key? key}) : super(key: key);

  @override
  _GMap createState() => _GMap();
}

class _GMap extends State<GMap> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(builder: (context, mapVM, child) {
      return Stack(children: [
        GoogleMap(
          onMapCreated: (controller) => mapVM.onMapCreated(controller),
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: mapVM.center,
            zoom: 11.0,
          ),
          markers: mapVM.markers.values.toSet(),
          onLongPress: mapVM.processLongPress,
          onTap: mapVM.processTap,
          onCameraMove: mapVM.processCameraMove,
        ),
        CustomInfoWindow(
          controller: mapVM.customInfoWindowController,
          height: 60,
          width: 250,
          offset: 48,
        ),
        Column(children: [
          mapVM.isSearchEnabled ? SearchBarView() : Container(),
          mapVM.isSearchEnabled
              ? SearchResultsView(onResultTap: (searchResult) {
                  mapVM.processSearchResultTap(searchResult);
                })
              : Container(),
          mapVM.isLoading ? LoadingView() : Container()
        ])
      ]);
    });
  }
}
