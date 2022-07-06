import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:chargeme/view_model/AddStationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeStationNameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              const Text(
                'Enter Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: context.read<AddStationViewModel>().name,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                onChanged: (text) {
                  var model = Provider.of<AddStationViewModel>(context, listen: false);
                  model.name = text;
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
