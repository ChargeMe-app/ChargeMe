import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BoxWithTitle extends StatelessWidget {
  BoxWithTitle({required this.title, this.children, this.footer, this.onFooterTap});

  final String title;
  final List<Widget>? children;
  final String? footer;
  final void Function()? onFooterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorPallete.violetBlue, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorPallete.violetBlue)),
              Column(children: children ?? []),
              footer == null
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                          color: ColorPallete.violetBlue, borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                          child: GestureDetector(
                              onTap: onFooterTap ?? () {},
                              child: Text(footer!,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)))))
            ])));
  }
}

class StationsListView extends StatelessWidget {
  StationsListView({required this.stations});

  List<Station> stations;

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return BoxWithTitle(
        title: l10n.stations,
        children: List.generate(stations.length, (i) {
          return outletListView(context, stations[i].outlets);
        }));
  }

  Widget outletListView(BuildContext context, List<Outlet> outlets) {
    return Container(
        height: 160,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(outlets.length, (i) {
              var outlet = outlets[i];
              return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(children: [
                    Image.asset(outlet.connectorType.iconPath, height: 90, color: ColorPallete.violetBlue),
                    SizedBox(height: 12),
                    Text(outlet.connectorType.str,
                        style: TextStyle(color: ColorPallete.violetBlue, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(outlet.kilowatts == null ? "" : "${outlet.kilowatts?.toInt().toString()} kWh",
                        style: TextStyle(fontSize: 12, color: ColorPallete.violetBlue))
                  ]));
              // return Card(
              //     color: ColorPallete.violetBlue,
              //     child: Padding(
              //         padding: EdgeInsets.all(8),
              //         child: Column(
              //           children: [
              //             Text(outlet.connectorType.str,
              //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              //             const Spacer(),
              //             Image.asset(outlet.connectorType.iconPath, height: 40, color: Colors.white),
              //             const Spacer(),
              //             Text(outlet.kilowatts == null ? "" : "${outlet.kilowatts?.toInt().toString()} kWh",
              //                 style: TextStyle(fontSize: 14, color: Colors.white))
              //           ],
              //         )));
            })));
  }
}
