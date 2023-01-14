import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/material.dart';

class BoxWithTitle extends StatelessWidget {
  BoxWithTitle(
      {required this.title, this.children, this.toolbar, this.footer, this.shouldShowFooter = false, this.onFooterTap});

  final String title;
  final List<Widget>? children;
  final Widget? toolbar;
  final String? footer;
  final bool shouldShowFooter;
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
              Row(children: [
                Spacer(),
                Text(title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorPallete.violetBlue)),
                Spacer(),
                toolbar == null ? Container() : toolbar!
              ]),
              Column(children: children ?? []),
              footer == null || !shouldShowFooter
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
  StationsListView({required this.stations, required this.comingSoon});

  final List<Station> stations;
  final bool comingSoon;

  @override
  Widget build(BuildContext context) {
    return BoxWithTitle(title: L10n.stations.str, children: [
      Container(
          height: 168,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(stations.length, (i) {
                return outletListView(
                    context, stations[i].outlets, stations.length - 1 == i, stations[i].checkins != null || comingSoon);
              })))
    ]);
  }

  Widget outletListView(BuildContext context, List<Outlet> outlets, bool isLast, bool isOccupied) {
    final outletColor = isOccupied ? Colors.grey : ColorPallete.violetBlue;
    return Row(children: [
      Row(
          children: List.generate(outlets.length, (i) {
        var outlet = outlets[i];
        return Padding(
            padding: EdgeInsets.all(8),
            child: Column(children: [
              Image.asset(outlet.connectorType.iconPath, height: 90, color: outletColor),
              SizedBox(height: 12),
              Text(outlet.connectorType.str,
                  style: TextStyle(color: outletColor, fontSize: 16, fontWeight: FontWeight.bold)),
              outlet.kilowatts == null
                  ? Container()
                  : Text("${outlet.kilowatts?.toInt().toString()} кВт",
                      style: TextStyle(fontSize: 12, color: outletColor)),
              outlet.price == null
                  ? Container()
                  : Text("${outlet.price!} ₽/кВт", style: TextStyle(fontSize: 12, color: outletColor))
            ]));
      })),
      isLast ? Container() : Container(width: 1, color: ColorPallete.violetBlue)
    ]);
  }
}
