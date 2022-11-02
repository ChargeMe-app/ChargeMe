import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:chargeme/extensions/datetime_extensions.dart';

class ReviewsView extends StatelessWidget {
  ReviewsView({required this.reviews});

  final List<Review> reviews;
  bool get hasExpandedReviews => reviews.length > 7;

  @override
  Widget build(BuildContext context) {
    return BoxWithTitle(
        title: L10n.checkins.str,
        footer: L10n.allCheckins.str,
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
    final TextStyle vehicleTextStyle = TextStyle(fontSize: 16, color: Colors.grey);
    final Size vehicleTextSize =
        _textSize(review.vehicleName?.capitalizeEachWord ?? L10n.unknownVehicle.str, vehicleTextStyle);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Padding(padding: EdgeInsets.only(right: 8), child: Container(width: 24, height: 24, child: review.rating.icon)),
        Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - vehicleTextSize.width - 84),
            child: Text(review.userName ?? L10n.unknownUser.str,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        const Spacer(),
        Text(review.vehicleName?.capitalizeEachWord ?? L10n.unknownVehicle.str,
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

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter =
        TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
          ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

class AllReviewsView extends StatelessWidget {
  AllReviewsView({required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(L10n.allCheckins.str), backgroundColor: ColorPallete.violetBlue),
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
