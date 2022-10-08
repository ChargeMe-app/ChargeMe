import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeStationPhoneView extends StatefulWidget {
  @override
  _ChangeStationPhoneView createState() => _ChangeStationPhoneView();
}

class _ChangeStationPhoneView extends State<ChangeStationPhoneView> {
  final _controller = TextEditingController();
  bool isGoodFormat = false;

  void validate(String str) {
    RegExp regExp = RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
    RegExpMatch? match = regExp.firstMatch(str);
    setState(() {
      isGoodFormat = match != null;
    });
  }

  AddStationViewModel get addStationVM {
    return Provider.of<AddStationViewModel>(context, listen: false);
  }

  @override
  void initState() {
    _controller.text = addStationVM.phoneNumber;
    validate(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.changePhoneNumber.str),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Text(
                L10n.enterPhoneNumber.str,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: L10n.phoneNumber.str,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        addStationVM.phoneNumber = "";
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                onChanged: (text) {
                  validate(text);

                  addStationVM.phoneNumber = text;
                },
              ),
              Text(isGoodFormat ? L10n.theFormatIsOk.str : L10n.badFormat.str,
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
