import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:chargeme/view/charging_place/amenities_view.dart';
import 'package:chargeme/view/charging_place/check_in/check_in_options_view.dart';
import 'package:chargeme/view/charging_place/check_in/current_check_in_view.dart';
import 'package:chargeme/view/charging_place/details_view.dart';
import 'package:chargeme/view/charging_place/reviews_view.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/view/helper_views/error_snack_bar.dart';
import 'package:chargeme/view/helper_views/title_text.dart';
import 'package:chargeme/view/login/profile_view.dart';
import 'package:chargeme/view/photo/photo_gallery_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:chargeme/view_model/charging_place_view_model.dart';
import 'package:chargeme/view_model/check_in_view_model.dart';
import 'package:chargeme/view_model/choose_vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/model/charging_place/charging_place.dart' as charging_place;
import 'package:flutter_svg/svg.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

class ChargingPlaceView extends StatefulWidget {
  const ChargingPlaceView({Key? key}) : super(key: key);

  @override
  _ChargingPlaceView createState() => _ChargingPlaceView();
}

class _ChargingPlaceView extends State<ChargingPlaceView> {
  double scrollUpOffset = 0;
  double imageContainerHeight = 200;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChargingPlaceViewModel>(builder: (context, chargingPlaceVM, child) {
      final place = chargingPlaceVM.place;
      if (place == null) {
        return Scaffold(
            appBar: AppBar(title: Text(L10n.appTitle.str), backgroundColor: ColorPallete.violetBlue),
            body: Center(child: Text(L10n.loading.str)));
      } else {
        return Scaffold(
            appBar: AppBar(title: Text(L10n.appTitle.str), backgroundColor: ColorPallete.violetBlue, actions: [
              GestureDetector(
                  onTap: () {
                    showActions();
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(width: 32, child: Image.asset(Asset.threeDots.path))))
            ]),
            body: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  setState(() {
                    final scrollVerticalOffset = scrollNotification.metrics.pixels;
                    if (scrollVerticalOffset < 0) {
                      scrollUpOffset = -scrollVerticalOffset;
                    }
                  });
                  return true;
                },
                child: SingleChildScrollView(
                    child: Transform.translate(
                        offset: Offset(0, -scrollUpOffset),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PhotosPreviewView(
                                photos: place.photos,
                                scrollUpOffset: scrollUpOffset,
                                imageContainerHeight: imageContainerHeight),
                            ChargingPlaceTitleView(place: place),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                                child: Column(children: [
                                  Column(
                                      children: List.generate(chargingPlaceVM.currentCheckins.length, (i) {
                                    final checkin = chargingPlaceVM.currentCheckins[i];
                                    return CurrentCheckInView(checkIn: checkin);
                                  })),
                                  CheckInButton(
                                      place: place,
                                      analyticsManager: chargingPlaceVM.analyticsManager,
                                      accountManager: chargingPlaceVM.accountManager),
                                  const SizedBox(height: 10),
                                  DetailsView(place: place, icon: chargingPlaceVM.icon),
                                  const SizedBox(height: 10),
                                  StationsListView(stations: place.stations),
                                  place.amenities?.isEmpty ?? true ? Container() : const SizedBox(height: 10),
                                  place.amenities?.isEmpty ?? true
                                      ? Container()
                                      : AmenitiesView(amenities: place.amenities!),
                                  place.reviews?.isEmpty ?? true ? Container() : const SizedBox(height: 10),
                                  place.reviews?.isEmpty ?? true
                                      ? Container()
                                      : ReviewsView(reviews: place.reviews ?? []),
                                  // const SizedBox(height: 10),
                                  // ControlButtonsView(),
                                ]))
                          ],
                        )))));
      }
    });
  }

  void showActions() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Consumer<ChargingPlaceViewModel>(builder: (context, chargingPlaceVM, child) {
            return Container(
                color: const Color(0xFF737373),
                height: 180,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Column(children: [
                      Padding(padding: const EdgeInsets.all(8), child: TitleText(L10n.actions.str)),
                      ListTile(
                          leading: SizedBox(width: 40, child: SvgPicture.asset(Asset.star.path)),
                          title: Text(
                              chargingPlaceVM.isInFavourites ? L10n.removeFromFavourites.str : L10n.addToFavourites.str,
                              style: TextStyle(fontSize: 18, color: ColorPallete.violetBlue)),
                          onTap: () {
                            chargingPlaceVM.isInFavourites
                                ? chargingPlaceVM.removeFromFavourites()
                                : chargingPlaceVM.saveToFavourites();
                          }),
                      ListTile(
                          leading: SizedBox(width: 40, child: SvgPicture.asset(Asset.info.path)),
                          title: Text(L10n.edit.str, style: TextStyle(fontSize: 18, color: ColorPallete.violetBlue)),
                          onTap: () {
                            if (chargingPlaceVM.place != null) {
                              context.read<AddStationViewModel>().setupForEditing(chargingPlaceVM.place!);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddStationView(),
                                ),
                              );
                            }
                          })
                    ])));
          });
        });
  }
}

class PhotosPreviewView extends StatelessWidget {
  final List<Photo>? photos;
  final double scrollUpOffset;
  final double imageContainerHeight;
  bool get hasPhotos {
    return !(photos?.isEmpty ?? true);
  }

  PhotosPreviewView({required this.photos, this.scrollUpOffset = 0, this.imageContainerHeight = 200});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(alignment: Alignment.bottomRight, children: [
        Container(
            height: imageContainerHeight + scrollUpOffset,
            color: Colors.grey,
            child: hasPhotos
                ? Hero(
                    tag: photos!.first.id,
                    child: Image.network(
                      photos!.first.url,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("No added photos yet", style: TextStyle(color: Colors.white, fontSize: 16))])),
        hasPhotos
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                    color: Colors.black54,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                        child: Text("${photos!.length} photos", style: TextStyle(color: Colors.white, fontSize: 14)))))
            : Container()
      ]),
      onTap: () {
        if (photos?.isNotEmpty ?? false) {
          Navigator.push(
              context,
              PageRouteBuilder(
                fullscreenDialog: true,
                pageBuilder: (_, __, ___) => PhotoGalleryView(photos: photos!),
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ));
        }
      },
    );
  }
}

class ChargingPlaceTitleView extends StatelessWidget {
  ChargingPlaceTitleView({this.place});

  final ChargingPlace? place;

  @override
  Widget build(BuildContext context) {
    final place = this.place!;
    return Consumer<ChargingPlaceViewModel>(builder: (context, chargingPlaceVM, child) {
      return Container(
          constraints: BoxConstraints(minHeight: 64),
          color: Colors.black12,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                place.score == null
                    ? Container()
                    : Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: place.score!.bgColor, borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                            child: Text(place.score!.beautifulScore,
                                style:
                                    const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)))),
                const SizedBox(width: 8),
                Flexible(
                    child: Text(place.isHomeCharger ? L10n.homeCharger.str : place.name.capitalizeEachWord,
                        maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
              ])));
    });
  }
}

class CheckInButton extends StatelessWidget {
  CheckInButton({this.place, required this.analyticsManager, required this.accountManager});

  final ChargingPlace? place;
  final AnalyticsManager analyticsManager;
  final AccountManager accountManager;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        primary: ColorPallete.violetBlue,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {
        if (place != null) {
          analyticsManager.logEvent("check_in_button_tapped", params: {"placeId": place!.id});
          if (accountManager.currentAccount != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (context) => CheckInViewModel(
                            place: place!,
                            analyticsManager: analyticsManager,
                            accountManager: accountManager,
                            chooseVehicleVM: context.read<ChooseVehicleViewModel>(),
                            chargingPlaceVM: context.read<ChargingPlaceViewModel>()),
                        child: CheckInOptionsView())));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignInView(
                        accountManager: accountManager,
                        onSuccess: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                      create: (context) => CheckInViewModel(
                                          place: place!,
                                          analyticsManager: analyticsManager,
                                          accountManager: accountManager,
                                          chooseVehicleVM: context.read<ChooseVehicleViewModel>(),
                                          chargingPlaceVM: context.read<ChargingPlaceViewModel>()),
                                      child: CheckInOptionsView())));
                        })));
          }
        }
      },
      child: Text(
        L10n.checkIn.str,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
