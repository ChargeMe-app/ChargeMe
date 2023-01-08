import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:chargeme/components/markers_manager/markers_manager.dart';
import 'package:chargeme/components/root_observer/root_observer.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/view/about/about_view.dart';
import 'package:chargeme/view/filters/filters_view.dart';
import 'package:chargeme/view/login/profile_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:chargeme/view_model/charging_place_view_model.dart';
import 'package:chargeme/view_model/choose_vehicle_view_model.dart';
import 'package:chargeme/view_model/debug_settings_view_model.dart';
import 'package:chargeme/view_model/filters_view_model.dart';
import 'package:chargeme/view_model/map_view_model.dart';
import 'package:chargeme/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/view/map/map.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final AnalyticsManager analyticsManager = AnalyticsManager();
  late final AccountManager accountManager = AccountManager(analytics: analyticsManager);
  late final MarkersManager markersManager = MarkersManager(analyticsManager: analyticsManager);

  MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // initialize on app start in order to load user preferred vehicles
  late ChooseVehicleViewModel chooseVehicleVM = ChooseVehicleViewModel(widget.accountManager, widget.analyticsManager);
  late SearchViewModel searchVM =
      SearchViewModel(analyticsManager: widget.analyticsManager, markersManager: widget.markersManager);
  late MapViewModel mapVM = MapViewModel(
      searchVM: searchVM,
      accountManager: widget.accountManager,
      analyticsManager: widget.analyticsManager,
      markersManager: widget.markersManager);

  @override
  void initState() {
    super.initState();
    IP.changeToDebugIPIfNeeded();
    widget.accountManager.tryLoadStoredAccount();
    initAnalyticsManager();
  }

  void initAnalyticsManager() async {
    await widget.analyticsManager.initialSetup();
    final userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    widget.analyticsManager.logEvent("session_started", params: {
      "device_locale": Get.deviceLocale?.languageCode,
      "user_lat": userLocation.latitude,
      "user_long": userLocation.longitude,
      "isSignedIn": widget.accountManager.currentAccount != null
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AddStationViewModel(analyticsManager: widget.analyticsManager)),
          ChangeNotifierProvider(
              create: (context) => ChargingPlaceViewModel(
                  accountManager: widget.accountManager, analyticsManager: widget.analyticsManager)),
          ChangeNotifierProvider(create: (context) => DebugSettingsViewModel()),
          ChangeNotifierProvider(create: (context) => FiltersViewModel(analyticsManager: widget.analyticsManager)),
          ChangeNotifierProvider.value(value: searchVM),
          ChangeNotifierProvider.value(value: mapVM),
          ChangeNotifierProvider.value(value: chooseVehicleVM),
        ],
        child: MaterialApp(
          navigatorObservers: [routeObserver],
          home: HomeView(
            accountManager: widget.accountManager,
            analyticsManager: widget.analyticsManager,
            markersManager: widget.markersManager,
            mapVM: mapVM,
          ),
        ));
  }
}

class HomeView extends StatelessWidget {
  final AccountManager accountManager;
  final AnalyticsManager analyticsManager;
  final MarkersManager markersManager;
  final MapViewModel mapVM;

  const HomeView(
      {required this.accountManager,
      required this.analyticsManager,
      required this.markersManager,
      required this.mapVM});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          // FloatingActionButton(
          //     heroTag: "search",
          //     backgroundColor: Colors.grey,
          //     child: const Icon(Icons.search),
          //     onPressed: () {
          //       // mapVM.isSearchEnabled = !mapVM.isSearchEnabled;
          //     }),
          // const SizedBox(height: 8),
          FloatingActionButton(
              heroTag: "filters",
              backgroundColor: ColorPallete.violetBlue,
              child: const Icon(Icons.filter_list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FiltersView(),
                  ),
                );
              }),
          const SizedBox(height: 8),
          FloatingActionButton(
              heroTag: "myLocation",
              backgroundColor: ColorPallete.violetBlue,
              child: const Icon(Icons.my_location),
              onPressed: () {
                mapVM.moveCameraToCurrentLocation();
              }),
        ]),
        appBar: AppBar(
          title: Text(L10n.appTitle.str),
          backgroundColor: ColorPallete.violetBlue,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddStationView(),
                  ),
                );
              },
              child: SizedBox(width: 16, child: Image.asset(scale: 1.9, color: Colors.white, Asset.pinWithPlus.path))),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutView(analyticsManager: analyticsManager),
                    ),
                  );
                },
                child: const Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.info))),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileView(accountManager: accountManager, analyticsManager: analyticsManager),
                    ),
                  );
                },
                child: const Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.account_circle_rounded)))
          ],
        ),
        body: const GMap());
  }
}
