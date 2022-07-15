import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view_model/AddStationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeStationDescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.changeDescription),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Text(
                l10n.enterDescription,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                minLines: 3,
                initialValue: context.read<AddStationViewModel>().description,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: l10n.description,
                ),
                onChanged: (text) {
                  var model = Provider.of<AddStationViewModel>(context, listen: false);
                  model.description = text;
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
