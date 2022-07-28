import 'package:chargeme/extensions/color_pallete.dart';
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
        title: "Checkins",
        footer: "All checkins",
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
  }
}

class AllReviewsView extends StatelessWidget {
  AllReviewsView({required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("All checkins"), backgroundColor: ColorPallete.violetBlue),
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
