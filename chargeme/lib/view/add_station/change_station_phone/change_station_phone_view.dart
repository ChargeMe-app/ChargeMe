import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeStationPhoneView extends StatefulWidget {
  @override
  _ChangeStationPhoneView createState() => _ChangeStationPhoneView();
}

class _ChangeStationPhoneView extends State<ChangeStationPhoneView> {
  bool isGoodFormat = false;

  void validate(String str) {
    RegExp regExp = RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
    RegExpMatch? match = regExp.firstMatch(str);
    setState(() {
      isGoodFormat = match != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.changePhoneNumber),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Text(
                l10n.enterPhoneNumber,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: context.read<AddStationViewModel>().phoneNumber,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<AddStationViewModel>().phoneNumber == "";
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: (text) {
                  validate(text);

                  var model = Provider.of<AddStationViewModel>(context, listen: false);
                  model.phoneNumber = text;
                },
              ),
              Text(isGoodFormat ? "The format is OK" : "Bad format",
                  style: TextStyle(color: isGoodFormat ? ColorPallete.greenEmerald : Colors.grey, fontSize: 16))
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: e,
                    ))
                .toList(),
          )),
    );
  }
}
