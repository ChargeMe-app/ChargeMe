import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/view/map/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoWithID {
  String id;
  String path;

  PhotoWithID(this.id, this.path);
}

class PhotoGalleryView extends StatefulWidget {
  final PageController pageController;

  PhotoGalleryView() : pageController = PageController(initialPage: 0);

  @override
  State<StatefulWidget> createState() {
    return _PhotoGalleryView();
  }
}

class _PhotoGalleryView extends State<PhotoGalleryView> {
  final items = [
    PhotoWithID("123", Asset.test_photo.path),
    PhotoWithID("321", Asset.icon.path),
    PhotoWithID("111", Asset.home64.path)
  ];
  int currentItem = 0;
  final double dismissThreshold = 100;
  double yOffset = 0;
  bool showsControls = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            showsControls = !showsControls;
          });
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
        child: Stack(alignment: Alignment.topCenter, children: [
          Container(
              color: Colors.black,
              child: Transform.translate(
                  offset: Offset(0, yOffset),
                  child: Container(
                      constraints: BoxConstraints.expand(
                        height: MediaQuery.of(context).size.height,
                      ),
                      child: PhotoViewGallery.builder(
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int i) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: AssetImage(items[i].path),
                            initialScale: PhotoViewComputedScale.contained * 0.98,
                            minScale: PhotoViewComputedScale.contained * 0.98,
                            maxScale: PhotoViewComputedScale.contained * 4,
                            heroAttributes: PhotoViewHeroAttributes(tag: items[i].id),
                          );
                        },
                        itemCount: items.length,
                        loadingBuilder: (context, event) => Center(
                          child: Container(width: 20.0, height: 20.0, child: LoadingView()),
                        ),
                        backgroundDecoration: null,
                        pageController: null,
                        onPageChanged: (i) {
                          setState(() {
                            currentItem = i;
                          });
                        },
                      )))),
          showsControls
              ? Column(children: [
                  Container(height: MediaQuery.of(context).padding.top, color: Colors.white10),
                  GalleryTopBar(
                      totalItems: items.length, currentItem: currentItem + 1, onCloseTap: () => Navigator.pop(context))
                ])
              : Container()
        ]));
  }
}

class GalleryTopBar extends StatelessWidget {
  int totalItems;
  int currentItem;
  Function onCloseTap;

  GalleryTopBar({required this.totalItems, required this.currentItem, required this.onCloseTap});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white10,
        child: Container(
            height: 48,
            child: Row(children: [
              IconButton(
                  onPressed: (() => onCloseTap()), icon: Icon(CupertinoIcons.xmark, size: 24, color: Colors.white)),
              const Spacer(),
              Text("$currentItem " + "of" + " $totalItems", style: TextStyle(color: Colors.white, fontSize: 18)),
              const Spacer(),
              Padding(padding: EdgeInsets.all(8), child: SizedBox(width: 26))
            ])));
  }
}
