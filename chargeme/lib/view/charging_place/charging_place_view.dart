import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:flutter/material.dart';
import '../../model/charging_place/charging_place.dart' as chargingPlace;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ChargingPlaceView extends StatefulWidget {
  const ChargingPlaceView({Key? key}) : super(key: key);

  @override
  _ChargingPlaceView createState() => _ChargingPlaceView();
}

class _ChargingPlaceView extends State<ChargingPlaceView> {
  ChargingPlace? place;

  @override
  void initState() {
    super.initState();
    setupChargingPlace();
  }

  void setupChargingPlace() async {
    place = (await chargingPlace.getTestStation())[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    if (place == null) {
      return Center(child: Text("Loading"));
    } else {
      return Scaffold(
          appBar: AppBar(title: Text(l10n.name), backgroundColor: ColorPallete.violetBlue),
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 200, color: Colors.grey),
              ChargingPlaceTitleView(place: place!),
              Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 24),
                  child: Column(children: [
                    CheckInButton(),
                    SizedBox(height: 10),
                    StationsListView(stations: place!.stations),
                    SizedBox(height: 10),
                    ReviewsView(reviews: place!.reviews)
                  ]))
            ],
          )));
    }
  }
}

class ChargingPlaceTitleView extends StatelessWidget {
  ChargingPlaceTitleView({required this.place});

  ChargingPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(children: [
              place.score == null
                  ? Container()
                  : Container(
                      width: 48,
                      height: 48,
                      decoration:
                          const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Center(
                          child: Text(place.score!.beautifulScore,
                              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)))),
              SizedBox(width: 8),
              Column(children: [Text(place.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))])
            ])));
  }
}

class CheckInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorPallete.violetBlue,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {},
      child: const Text(
        'Check In',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ReviewsView extends StatelessWidget {
  ReviewsView({required this.reviews});

  List<Review> reviews;
  bool get hasExpandedReviews => reviews.length > 7;

  @override
  Widget build(BuildContext context) {
    return BoxWithTitle(title: "Checkins", children: [
      Column(
          children: List.generate(hasExpandedReviews ? 7 : reviews.length, (i) {
        return checkInView(context, reviews[i]);
      })),
      Row(children: [
        Spacer(),
        Text("All checkins",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPallete.violetBlue))
      ])
    ]);
  }

  Widget checkInView(BuildContext context, Review review) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 32, child: review.rating.icon),
        Text(review.user.displayName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Spacer(),
        Text(review.vehicleName?.capitalizeEachWord ?? "Unknown vehicle",
            style: TextStyle(fontSize: 16, color: Colors.grey))
      ]),
      review.comment == ""
          ? Container()
          : Row(children: [
              Container(width: 32),
              Flexible(child: Text(review.comment, maxLines: null, style: TextStyle(fontStyle: FontStyle.italic))),
            ]),
      Row(children: [
        Container(width: 32),
        Text(review.connectorType?.str ?? "", style: TextStyle(fontSize: 16, color: Colors.grey)),
        Spacer(),
        Text(review.createdAt.dateAndTimeFormat, style: TextStyle(fontSize: 14, color: Colors.grey))
      ]),
      SizedBox(height: 20)
    ]);
    // ]);
  }
}

extension CapExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeEachWord => this.split(" ").map((str) => str.capitalize).join(" ");
}

extension DateFormatter on DateTime {
  String get dateAndTimeFormat {
    final DateFormat formatter = DateFormat('dd.MM.yyyy, H:m');
    final String formatted = formatter.format(this);
    return formatted; // something like 2013-04-20
  }
}
