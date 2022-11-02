import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/view/map/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:chargeme/extensions/datetime_extensions.dart';

const Color controlsColor = Colors.white10;

class PhotoGalleryView extends StatefulWidget {
  final List<Photo> photos;

  PhotoGalleryView({required this.photos});

  @override
  State<StatefulWidget> createState() {
    return _PhotoGalleryView();
  }
}

class _PhotoGalleryView extends State<PhotoGalleryView> {
  int currentItem = 0;
  final double dismissThreshold = 50;
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
                          final photo = widget.photos[i];
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(photo.url),
                            initialScale: PhotoViewComputedScale.contained * 0.98,
                            minScale: PhotoViewComputedScale.contained * 0.98,
                            maxScale: PhotoViewComputedScale.contained * 4,
                            heroAttributes: PhotoViewHeroAttributes(tag: photo.id),
                          );
                        },
                        itemCount: widget.photos.length,
                        loadingBuilder: (context, event) => Center(
                          child: Container(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white)),
                        ),
                        backgroundDecoration: null,
                        pageController: null,
                        onPageChanged: (i) {
                          setState(() {
                            currentItem = i;
                          });
                        },
                      )))),
          AnimatedOpacity(
              opacity: showsControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              child: Column(children: [
                Container(height: MediaQuery.of(context).padding.top, color: controlsColor),
                GalleryTopBar(
                    totalItems: widget.photos.length,
                    currentItem: currentItem + 1,
                    onCloseTap: () => Navigator.pop(context)),
                const Spacer(),
                GalleryBottomBar(photo: widget.photos[currentItem]),
                Container(height: MediaQuery.of(context).padding.bottom, color: controlsColor),
              ]))
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
        color: controlsColor,
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

class GalleryBottomBar extends StatelessWidget {
  Photo photo;
  bool get hasCaption {
    return !(photo.caption == null || photo.caption == "");
  }

  GalleryBottomBar({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: controlsColor,
        child: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
              child: Column(children: [
            hasCaption
                ? Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(photo.caption!,
                        textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16)))
                : Container(),
            Padding(
                padding: EdgeInsets.only(top: hasCaption ? 0 : 8),
                child: Text(photo.createdAt.dateAndTimeFormat,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(color: Colors.grey, fontSize: hasCaption ? 12 : 14)))
          ]))
        ])));
  }
}
