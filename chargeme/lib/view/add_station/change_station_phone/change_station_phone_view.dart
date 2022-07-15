import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view_model/AddStationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeStationPhoneView extends StatelessWidget {
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
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '+7 (9XX) XXX-XX-XX',
                ),
                onChanged: (text) {
                  var model = Provider.of<AddStationViewModel>(context, listen: false);
                  model.phoneNumber = text;
                },
              )
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
