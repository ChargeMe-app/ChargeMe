import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/about/about_view.dart';
import 'package:chargeme/view/login/profile_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/view/map/map.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final AnalyticsManager analyticsManager = AnalyticsManager();
  late AccountManager accountManager = AccountManager(analytics: analyticsManager);

  MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.accountManager.tryLoadStoredAccount();
    widget.analyticsManager.initialSetup();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddStationViewModel(analyticsManager: widget.analyticsManager),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeView(accountManager: widget.accountManager, analyticsManager: widget.analyticsManager),
        ));
  }
}

class HomeView extends StatelessWidget {
  final AccountManager accountManager;
  final AnalyticsManager analyticsManager;

  HomeView({required this.accountManager, required this.analyticsManager});

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
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutView(),
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
        body: GMap(accountManager: accountManager, analyticsManager: analyticsManager));
  }
}
