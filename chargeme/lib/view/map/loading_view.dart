import 'package:chargeme/gen/l10n.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        duration: const Duration(milliseconds: 400),
        builder: (BuildContext context, double opacity, Widget? child) {
          return Opacity(opacity: opacity, child: child);
        },
        child: Container(
            color: Colors.black38,
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("${L10n.loading.str}...", style: TextStyle(color: Colors.white))),
              const Spacer(),
              Padding(
                  padding: EdgeInsets.all(8), child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white))
            ])));
  }
}
