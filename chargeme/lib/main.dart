import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/charging_place/check_in/check_in_options_view.dart';
import 'package:chargeme/view/login/profile_view.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:chargeme/view_model/check_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/view/map/map.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => AddStationViewModel(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  final AccountManager accountManager = AccountManager();

  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.accountManager.tryLoadStoredAccount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeView(accountManager: widget.accountManager),
    );
  }
}

class HomeView extends StatelessWidget {
  final AccountManager accountManager;

  HomeView({required this.accountManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).appTitle),
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
              child: const Icon(Icons.location_pin)),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (context) => CheckInViewModel(),
                            child: CheckInOptionsView(
                                place: ChargingPlace(
                                    id: "123",
                                    name: "Плющиха",
                                    description: "hello world",
                                    latitude: 55.7558,
                                    longitude: 37.6173,
                                    photos: [],
                                    reviews: [],
                                    stations: [
                                  Station(id: "111", locationId: "123", available: 1, cost: 0, outlets: [
                                    Outlet(id: "111", connectorType: ConnectorType.chademo),
                                    Outlet(id: "222", connectorType: ConnectorType.cssCombo),
                                    Outlet(id: "333", connectorType: ConnectorType.type2)
                                  ])
                                ])) // ProfileView(accountManager: accountManager),
                            ),
                      ));
                },
                child: const Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.account_circle_rounded)))
          ],
        ),
        body: const GMap());
  }
}
