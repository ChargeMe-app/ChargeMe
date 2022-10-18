import 'package:chargeme/gen/assets.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key}) : super(key: key);

  @override
  _PhotoView createState() => _PhotoView();
}

class _PhotoView extends State<PhotoView> {
  final double dismissThreshold = 200;
  double yOffset = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Opacity(
          opacity: (dismissThreshold - yOffset.abs().clamp(0, dismissThreshold)) / dismissThreshold,
          child: Container(
              color: Colors.black,
              child: Transform.translate(offset: Offset(0, yOffset), child: Image.asset(Asset.test_photo.path)))),
      onTap: () {
        Navigator.pop(context);
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          yOffset += details.delta.dy;
        });
      },
      onVerticalDragEnd: ((details) {
        if (yOffset.abs() > dismissThreshold) {
          Navigator.pop(context);
        } else {
          setState(() {
            yOffset = 0;
          });
        }
      }),
    );
  }
}
