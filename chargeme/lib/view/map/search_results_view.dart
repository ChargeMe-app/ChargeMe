import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';

class SearchResultsView extends StatelessWidget {
  final Function(SearchResult) onResultTap;

  SearchResultsView({required this.onResultTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, searchVM, child) {
      return Container(
          color: Colors.white,
          child: Column(
              children: List.generate(searchVM.results.length, (i) {
            final searchEntry = searchVM.results[i];
            return ListTile(
              leading: searchEntry.type == SearchResultType.address
                  ? SvgPicture.asset(Asset.pin.path, height: 40)
                  : Image.asset(searchEntry.iconType!.assetPath, height: 40),
              title: Text(searchEntry.title),
              subtitle: Text(searchEntry.subtitle ?? "", style: TextStyle(color: Colors.grey, fontSize: 14)),
              onTap: () {
                onResultTap(searchEntry);
              },
            );
          })));
    });
  }
}
