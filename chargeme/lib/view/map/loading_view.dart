import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
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
                  padding: EdgeInsets.all(8), child: Text("${l10n.loading}...", style: TextStyle(color: Colors.white))),
              Spacer(),
              Padding(
                  padding: EdgeInsets.all(8), child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white))
            ])));
  }
}
