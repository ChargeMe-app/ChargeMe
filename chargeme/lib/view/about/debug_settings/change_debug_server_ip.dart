import 'package:chargeme/components/helpers/ip.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:chargeme/view_model/debug_settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeDebugServerIPView extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Server IP"),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(children: [
            const Text(
              "ВВедите IP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                maxLength: 48,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: IP.current,
                )),
            SimpleButton(
                color: ColorPallete.violetBlue,
                text: "Сохранить",
                onPressed: () {
                  Provider.of<DebugSettingsViewModel>(context, listen: false)
                      .setStringValueForKey("debugServerIP", _controller.text);
                }),
            const SizedBox(height: 12),
            SimpleButton(
                color: ColorPallete.violetBlue,
                text: "Использовать дефолтный",
                onPressed: () {
                  Provider.of<DebugSettingsViewModel>(context, listen: false).removeValueForKey("debugServerIP");
                })
          ])),
    );
  }
}
