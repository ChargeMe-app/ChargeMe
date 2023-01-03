import 'package:chargeme/components/root_observer/root_observer.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:chargeme/view/common/switch_setting_row.dart';
import 'package:chargeme/view/common/place_score_view.dart';
import 'package:chargeme/view_model/filters_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersView extends StatefulWidget {
  FiltersView({super.key});

  @override
  _FiltersView createState() => _FiltersView();
}

class _FiltersView extends State<FiltersView> with RouteAware {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void didPop() {
    final filtersVM = Provider.of<FiltersViewModel>(context, listen: false);
    filtersVM.save();
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FiltersViewModel>(builder: (context, filtersVM, child) {
      return Scaffold(
          appBar: AppBar(title: Text(L10n.filters.str), backgroundColor: ColorPallete.violetBlue, actions: [
            CupertinoButton(
                child: Center(child: Text(L10n.reset.str, style: const TextStyle(color: Colors.white, fontSize: 16))),
                onPressed: () {
                  filtersVM.reset();
                })
          ]),
          body: ListView(children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(children: [
                  Text(L10n.connectors.str, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Spacer(),
                  CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      child: Text(L10n.deselectAll.str),
                      onPressed: () {
                        filtersVM.deselectConnectors();
                      })
                ])),
            Container(height: 0.5, color: ColorPallete.violetBlue),
            Column(
                children: List.generate(ConnectorType.values.length, (i) {
              final connectorType = ConnectorType.values[i];
              final isSelected = filtersVM.connectors.contains(connectorType);
              return Container(
                  decoration:
                      BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: ColorPallete.violetBlue))),
                  child: ListTile(
                      title: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                        SizedBox(
                            width: 32,
                            height: 32,
                            child: Image.asset(connectorType.iconPath,
                                color: isSelected ? ColorPallete.violetBlue : null)),
                        const SizedBox(width: 8),
                        Text(connectorType.str)
                      ]),
                      trailing: isSelected
                          ? SizedBox(width: 24, child: Icon(CupertinoIcons.check_mark))
                          : Container(width: 24),
                      selected: isSelected,
                      selectedColor: ColorPallete.violetBlue,
                      onTap: () {
                        filtersVM.switchConnectorType(connectorType);
                      }));
            })),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(children: [
                  Text(L10n.scoreRange.str, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Spacer(),
                  PlaceScoreView(score: filtersVM.minScore),
                  const Text(" - "),
                  PlaceScoreView(score: filtersVM.maxScore)
                ])),
            RangeSlider(
                activeColor: ColorPallete.violetBlue,
                inactiveColor: ColorPallete.violetBlue.withAlpha(51),
                max: 10,
                values: RangeValues(filtersVM.minScore, filtersVM.maxScore),
                onChanged: (values) {
                  filtersVM.setScoreRange(values);
                }),
            SwitchSettingRow(
                iconPath: IconType.publicStandard.assetPath,
                title: L10n.showPublicPlaces.str,
                value: filtersVM.showPublic,
                onChanged: (value) => filtersVM.showPublic = value),
            SwitchSettingRow(
                iconPath: IconType.publicFast.assetPath,
                title: L10n.showPublicFastPlaces.str,
                value: filtersVM.showPublicFast,
                onChanged: (value) => filtersVM.showPublicFast = value),
            SwitchSettingRow(
                iconPath: IconType.home.assetPath,
                title: L10n.showHomePlaces.str,
                value: filtersVM.showHome,
                onChanged: (value) => filtersVM.showHome = value),
            SwitchSettingRow(
                iconPath: IconType.repairStandard.assetPath,
                title: L10n.showComingSoonPlaces.str,
                value: filtersVM.showComingSoon,
                onChanged: (value) => filtersVM.showComingSoon = value),
            SwitchSettingRow(
                title: L10n.showPaidChargingPlaces.str,
                value: filtersVM.showPaid,
                onChanged: (value) => filtersVM.showPaid = value),
            SwitchSettingRow(
                title: L10n.showplacesWithCheckin.str,
                value: filtersVM.showWithCheckin,
                onChanged: (value) => filtersVM.showWithCheckin = value),
          ]));
    });
  }
}
