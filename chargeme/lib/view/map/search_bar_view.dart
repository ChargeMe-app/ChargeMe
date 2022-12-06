import 'package:chargeme/components/helpers/throttler.dart';
import 'package:chargeme/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
        builder: (context, searchVM, child) => Container(
            // height: 42,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(children: [
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Flexible(
                      child: TextFormField(
                          controller: searchVM.controller,
                          focusNode: searchVM.focusNode,
                          keyboardType: TextInputType.streetAddress,
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(hintText: "Search"),
                          onChanged: (value) {
                            searchVM.throttler.throttle(Duration(milliseconds: 400), () async {
                              await searchVM.fetchResults(value);
                            });
                          })),
                ]))));
  }
}
