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
  final String supportEmail = "chargemesup@gmail.com";
  final String tgLink = "https://t.me/+kL8UiiPz0pY0MGVi";

  String version = "";
  double spacing = 12.0;
  final TextEditingController _controller = TextEditingController();
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
    const double padding = 16;
    const double logoWidth = 32;
    const double serviceTextWidth = 72;
    final screenWidthWithPadding = MediaQuery.of(context).size.width - 16;
    return Scaffold(
        appBar: AppBar(title: Text("About"), backgroundColor: ColorPallete.violetBlue),
        body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      title("ChargeMe"),
                      SizedBox(height: spacing),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12), child: Image.asset(Asset.icon.path, height: 100)),
                      SizedBox(height: spacing),
                      Text(version, style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(height: spacing),
                      title("Report a bug"),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      SimpleButton(
                          color: _controller.text.isEmpty ? Colors.grey : ColorPallete.violetBlue,
                          text: "Send",
                          onPressed: () {}),
                      SizedBox(height: spacing),
                      title("Contact us"),
                      const SizedBox(height: 8),
                      Row(children: [
                        Image.asset(Asset.telegramLogo.path, height: logoWidth),
                        const SizedBox(width: 8),
                        SizedBox(width: serviceTextWidth, child: Text("Telegram:")),
                        const SizedBox(width: 4),
                        GestureDetector(
                            onTap: () async {
                              launchUrl(Uri.parse(tgLink));
                            },
                            child: Container(
                                width: screenWidthWithPadding - serviceTextWidth - logoWidth - 8 - 4 - 16,
                                child: Text(tgLink, overflow: TextOverflow.fade, style: TextStyle(color: Colors.blue))))
                      ]),
                      const SizedBox(height: 12),
                      Row(children: [
                        Image.asset(Asset.appleMail.path, height: logoWidth),
                        const SizedBox(width: 8),
                        SizedBox(width: serviceTextWidth, child: Text("Email:")),
                        const SizedBox(width: 4),
                        GestureDetector(
                            onLongPress: () async {
                              Clipboard.setData(ClipboardData(text: supportEmail));
                              final snackBar = SnackBar(
                                content: Text("Copied to clipboard"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: SizedBox(
                                width: screenWidthWithPadding - serviceTextWidth - logoWidth - 8 - 4 - 16,
                                child: Text(supportEmail,
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue))))
                      ]),
                      const SizedBox(height: 24)
                    ])))));
  }

  Widget title(String text) {
    return Text(text, style: TextStyle(color: ColorPallete.violetBlue, fontWeight: FontWeight.bold, fontSize: 18));
  }
}
