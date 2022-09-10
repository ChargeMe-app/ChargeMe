import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:chargeme/extensions/datetime_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewsView extends StatelessWidget {
  ReviewsView({required this.reviews});

  final List<Review> reviews;
  bool get hasExpandedReviews => reviews.length > 7;

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return BoxWithTitle(
        title: l10n.checkins,
        footer: l10n.allCheckins,
        shouldShowFooter: reviews.length > 7,
        onFooterTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllReviewsView(reviews: reviews),
            ),
          );
        },
        children: List.generate(hasExpandedReviews ? 7 : reviews.length, (i) {
          return CheckInView(reviews[i]);
        }));
  }
}

class CheckInView extends StatelessWidget {
  CheckInView(this.review);

  final Review review;

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Padding(padding: EdgeInsets.only(right: 8), child: Container(width: 24, child: review.rating.icon)),
        Text(review.userName ?? l10n.unknownUser, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Spacer(),
        Text(review.vehicleName?.capitalizeEachWord ?? l10n.unknownVehicle,
            maxLines: 1, overflow: TextOverflow.fade, style: TextStyle(fontSize: 16, color: Colors.grey))
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
        const Spacer(),
        Text(review.createdAt.dateAndTimeFormat, style: TextStyle(fontSize: 14, color: Colors.grey))
      ]),
      const SizedBox(height: 20)
    ]);
  }
}

class AllReviewsView extends StatelessWidget {
  AllReviewsView({required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(title: Text(l10n.allCheckins), backgroundColor: ColorPallete.violetBlue),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
          child: Column(
              children: List.generate(reviews.length, (i) {
            return CheckInView(reviews[i]);
          })),
        )));
  }
}
