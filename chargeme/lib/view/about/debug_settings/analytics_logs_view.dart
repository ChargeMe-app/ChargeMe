import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/event/event.dart';
import 'package:flutter/material.dart';

class AnalyticsLogsView extends StatelessWidget {
  final AnalyticsManager analyticsManager;

  const AnalyticsLogsView({required this.analyticsManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Analytics logs"),
          backgroundColor: ColorPallete.violetBlue,
        ),
        body: SingleChildScrollView(
            child: Column(
                children: List.generate(analyticsManager.storedEvents.length, (i) {
          final event = analyticsManager.storedEvents[i];
          return Padding(
              padding: const EdgeInsets.all(4),
              child: Column(children: [
                Row(children: [
                  Text("EVENT: " + event.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                ]),
                Row(children: [
                  Flexible(
                      child: SelectableText("Params: " + cleanedEventParams(event),
                          style: const TextStyle(color: Colors.grey)))
                ])
              ]));
        }))));
  }

  String cleanedEventParams(Event event) {
    Map<String, dynamic> params = event.parameters;
    params.remove("model");
    params.remove("timestamp");
    params.remove("platform");
    return params.toString();
  }
}
