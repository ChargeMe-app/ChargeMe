import 'dart:io';

import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutView createState() => _AboutView();
}

class _AboutView extends State<AboutView> {
  String version = "";
  double spacing = 12.0;
  TextEditingController _controller = TextEditingController();
  PackageInfo? packageInfo;
  DeviceInfoPlugin? deviceInfo;

  @override
  void initState() {
    super.initState();
    initialSetup();
  }

  Future<void> initialSetup() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = "Version: ${packageInfo?.version} (${packageInfo?.buildNumber})";
    });
  }

  Future<void> sendFeedback() async {
    String? osVersion;
    String? deviceName;

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      osVersion = deviceInfo.systemVersion;
      deviceName = deviceInfo.name;
    }
    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      osVersion = deviceInfo.version.toString();
      deviceName = deviceInfo.device;
    }

    Map<String, dynamic> postBody = {
      "text": _controller.text,
      "app_version": packageInfo?.version,
      "app_build_number": packageInfo?.buildNumber,
      "device_os": osVersion,
      "device_name": deviceName
    };

    // send to backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("About"), backgroundColor: ColorPallete.violetBlue),
        body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      title("ChargeMe"),
                      SizedBox(height: spacing),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12), child: Image.asset(Asset.icon.path, height: 100)),
                      SizedBox(height: spacing),
                      Text(version, style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(height: spacing),
                      title("Report a bug"),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _controller,
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                            hintText: "Write any comments or suggestions directly to developers",
                            hintMaxLines: 2,
                            fillColor: ColorPallete.violetBlue,
                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue))),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 8),
                      SimpleButton(
                          color: _controller.text.isEmpty ? Colors.grey : ColorPallete.violetBlue,
                          text: "Send",
                          onPressed: () {}),
                      SizedBox(height: spacing),
                      title("Contact us"),
                      SizedBox(height: 8),
                      Row(children: [
                        Image.asset(Asset.telegramLogo.path, height: 32),
                        SizedBox(width: 8),
                        Flexible(child: Text("Telegram:")),
                        SizedBox(width: 4),
                        GestureDetector(
                            onTap: () async {
                              launchUrl(Uri.parse("https://t.me/+kL8UiiPz0pY0MGVi"));
                            },
                            child: Flexible(
                                child: Text("https://t.me/+kL8UiiPz0pY0MGVi",
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue))))
                      ]),
                      SizedBox(height: 12),
                      Row(children: [
                        Image.asset(Asset.appleMail.path, height: 32),
                        SizedBox(width: 8),
                        Flexible(child: Text("Email:")),
                        SizedBox(width: 4),
                        GestureDetector(
                            onLongPress: () async {
                              Clipboard.setData(ClipboardData(text: "chargemesup@gmail.com"));
                              final snackBar = SnackBar(
                                content: const Text("Copied to clipboard"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Flexible(
                                child: Text("chargemesup@gmail.com",
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue))))
                      ]),
                      SizedBox(height: 24)
                    ])))));
  }

  Widget title(String text) {
    return Text(text, style: TextStyle(color: ColorPallete.violetBlue, fontWeight: FontWeight.bold, fontSize: 18));
  }
}
