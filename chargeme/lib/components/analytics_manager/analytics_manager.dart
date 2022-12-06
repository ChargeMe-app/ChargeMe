import 'dart:convert';
import 'dart:io';

import 'package:chargeme/model/event/event.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AnalyticsManager {
  String? deviceModel;
  List<Event> storedEvents = [];
  String filename;

  AnalyticsManager() : filename = "events_${DateTime.now().toIso8601String()}";

  Future<File> get storedFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/analytics/$filename.json");
  }

  Future<void> initialSetup() async {
    (await storedFile).create(recursive: true);
    deviceModel = await _getId();
  }

  Future<void> logEvent(String name, {Map<String, dynamic>? params}) async {
    final event = Event(name: name, parameters: params ?? {});
    event.parameters["model"] = deviceModel;
    event.parameters["timestamp"] = DateTime.now().toIso8601String();
    event.parameters["platform"] = Platform.operatingSystem.toString();
    print("EVENT: ${event.name}; PARAMETERS: ${event.parameters}");

    final file = await storedFile;
    storedEvents.add(event);
    file.writeAsString(jsonEncode(storedEvents));
  }

  Future<void> logErrorEvent(String errorDescription) async {
    final event = Event(name: "error", parameters: {
      "description": errorDescription,
      "model": deviceModel,
      "timestamp": DateTime.now().toIso8601String(),
      "platform": Platform.operatingSystem.toString()
    });

    print("ERROR. PARAMETERS: ${event.parameters}");
    final file = await storedFile;
    storedEvents.add(event);
    file.writeAsString(jsonEncode(storedEvents));
  }

  Future<void> sendCachedEvents() async {
    // TODO: Implement this method
    final encodedJson = jsonEncode(storedEvents);
    try {
      http.post(Uri.parse("http://${IP.current}/v1/"), body: encodedJson);
    } catch (error) {
      print(error);
    }
  }
}

Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.model;
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.device;
  }
}
